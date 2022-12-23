package it.unisa.emad.feeltheart.util;

import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTCreator.Builder;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.auth0.jwt.exceptions.TokenExpiredException;
import com.auth0.jwt.interfaces.Claim;
import it.unisa.emad.feeltheart.constant.Constant;
import it.unisa.emad.feeltheart.constant.LogMessage;
import it.unisa.emad.feeltheart.dto.token.*;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.security.InvalidKeyException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

@Log4j2
@Component
public class TokenUtils {

    @Value(value = "${token.oauth2.jwt.secret}")
    private String jwtSecret;

    @Value(value = "${token.oauth2.jwt.duration.minutes}")
    private String jwtDuration;

    @Value(value = "${token.oauth2.issuer}")
    private String issuer;

    @Value(value = "${token.oauth2.type}")
    private String tokenType;

    @Value(value = "${token.encryption.key}")
    private String secret;

    @Value(value = "${token.encryption.algorithm}")
    private String algorithm;

    private static SecretKeySpec secretKey;
    private final DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    private final FeelTheArtUtils feelTheArtUtils;

     @Autowired
    public TokenUtils(FeelTheArtUtils feelTheArtUtils) {
        this.feelTheArtUtils = feelTheArtUtils;
    }

    public GenerateTokenResponseDto generateToken(GenerateTokenRequestDto request) {
        log.info(LogMessage.START);

        var response = new GenerateTokenResponseDto();
        Builder token = JWT.create();

        try {
            Map<String, String> params = request.getParams();
            if(null != params && !params.isEmpty()) {
                params.forEach(token::withClaim);
            }

            response.setToken(getToken(getExpireDate(), getAlgorithm(), token));
            response.success(feelTheArtUtils.getMessageResponse(
                    Constant.MESSAGE_RESPONSE_GENERATE_TOKEN_OK));

            log.info(LogMessage.END);
            return response;
        } catch (Exception e) {
            log.error(LogMessage.ERROR, e.getMessage());
            response.error(feelTheArtUtils.getMessageResponse(
                    Constant.MESSAGE_RESPONSE_GENERATE_TOKEN_KO));
            return response;
        }
    }

    public ValidateTokenResponseDto validateToken(ValidateTokenRequestDto request) {
        log.info(LogMessage.START);

        var result = new ValidateTokenResponseDto();

        try {
            String token = decryptToken(request.getToken());

            JWTVerifier verifier = JWT.require(getAlgorithm())
                    .withIssuer(issuer)
                    .build();

            verifier.verify(token);

            result.success(feelTheArtUtils.getMessageResponse(
                    Constant.MESSAGE_RESPONSE_VALIDATE_TOKEN_OK));

        } catch (TokenExpiredException tee) {
            log.info(LogMessage.ERROR, "token expired");
            result.error(feelTheArtUtils.getMessageResponse(
                    Constant.MESSAGE_RESPONSE_TOKEN_EXPIRED));
        } catch (JWTVerificationException jve) {
            log.info(LogMessage.ERROR, "invalid token");
            result.error(feelTheArtUtils.getMessageResponse(
                    Constant.MESSAGE_RESPONSE_VALIDATE_TOKEN_KO));
        } catch (Exception e) {
            log.info(LogMessage.ERROR, e.getMessage());
            result.error(feelTheArtUtils.getMessageResponse(
                    Constant.MESSAGE_RESPONSE_VALIDATE_TOKEN_KO));
        }

        log.info(LogMessage.END);
        return result;
    }

    public RefreshTokenResponseDto refreshToken(RefreshTokenRequestDto request) {
        log.info(LogMessage.START);

        String encryptedToken = request.getToken();
        Builder token = JWT.create();
        var response = new RefreshTokenResponseDto();

        try {
            String tokenToRefresh = decryptToken(encryptedToken);

            Map<String, Claim> claims = JWT.decode(tokenToRefresh).getClaims();
            if(null != claims && !claims.isEmpty()) {
                claims.forEach((k, v) -> token.withClaim(k, v.asString()));
            }

            response.setToken(getToken(getExpireDate(), getAlgorithm(), token));
            response.success(feelTheArtUtils.getMessageResponse(
                    Constant.MESSAGE_RESPONSE_REFRESH_TOKEN_OK));

            log.info(LogMessage.END);
            return response;
        } catch (Exception e) {
            log.error(LogMessage.ERROR, e.getMessage());
            response.error(feelTheArtUtils.getMessageResponse(
                    Constant.MESSAGE_RESPONSE_REFRESH_TOKEN_KO));
            return response;
        }
    }

    public GetClaimsFromTokenResponseDto getClaimsFromToken(GetClaimsFromTokenRequestDto request) {
         log.info(LogMessage.START);

         var result = new GetClaimsFromTokenResponseDto();

         var validationResult = this.validateToken(new ValidateTokenRequestDto(request.getToken()));

         if (Boolean.FALSE.equals(validationResult.getSuccess())) {
             log.error(feelTheArtUtils.getMessageResponse(Constant.MESSAGE_RESPONSE_VALIDATE_TOKEN_KO));
             result.error(validationResult.getDescription());
             return result;
         }

        try {
            String decryptToken = this.decryptToken(request.getToken());

            var token = JWT.decode(decryptToken);

            Map<String, String> params = new HashMap<>();
            token.getClaims().forEach((k, v) -> params.put(k, v.asString()));
            params.values().removeAll(Collections.singleton(null));

            result.success(feelTheArtUtils.getMessageResponse(Constant.MESSAGE_RESPONSE_INFO_TOKEN_OK));
            result.setParams(params);
        }catch (Exception e) {
            log.error(LogMessage.ERROR, e.getMessage());
            result.error(feelTheArtUtils.getMessageResponse(Constant.MESSAGE_RESPONSE_INFO_TOKEN_KO));
        }

        log.info(LogMessage.END);
        return result;
    }

    private Oauth2Dto getToken(Date expirationDate, Algorithm algorithm, Builder token)
            throws NoSuchPaddingException,
            IllegalBlockSizeException,
            NoSuchAlgorithmException,
            BadPaddingException,
            InvalidKeyException {

        var oauth2 = new Oauth2Dto();

        String tokenString = token
                .withIssuer(issuer)
                .withIssuedAt(new Date(System.currentTimeMillis()))
                .withExpiresAt(expirationDate)
                .sign(algorithm);

        String encryptedToken = encryptToken(tokenString);

        oauth2.setAccess_token(encryptedToken);
        oauth2.setExpires_at(dateFormat.format(getExpireDate()));
        oauth2.setToken_type(tokenType);

        return oauth2;
    }

    private String encryptToken(String token)
            throws InvalidKeyException,
            NoSuchPaddingException,
            NoSuchAlgorithmException,
            IllegalBlockSizeException,
            BadPaddingException {

        setKey(secret);
        Cipher cipher = Cipher.getInstance(algorithm);
        cipher.init(Cipher.ENCRYPT_MODE, secretKey);
        return Base64.getEncoder().encodeToString(cipher.doFinal(token.getBytes(StandardCharsets.UTF_8)));
    }

    private String decryptToken(String strToDecrypt)
            throws NoSuchPaddingException,
            NoSuchAlgorithmException,
            InvalidKeyException,
            IllegalBlockSizeException,
            BadPaddingException {

         setKey(secret);
        Cipher cipher = Cipher.getInstance(algorithm);
        cipher.init(Cipher.DECRYPT_MODE, secretKey);
        return new String(cipher.doFinal(Base64.getDecoder().decode(strToDecrypt)));
    }

    private static void setKey(String secret) {
        MessageDigest messageDigest;
        try {
            byte[] key = secret.getBytes(StandardCharsets.UTF_8);
            messageDigest = MessageDigest.getInstance("SHA-1");
            key = messageDigest.digest(key);
            key = Arrays.copyOf(key, 16);
            secretKey = new SecretKeySpec(key, "AES");
        }
        catch (NoSuchAlgorithmException e) {
            log.error(LogMessage.ERROR + e.getMessage());
        }
    }

    private Date getExpireDate() {
        long millisecond = Long.parseLong(jwtDuration) * 60000;
        return new Date(System.currentTimeMillis() + millisecond);
    }

    private Algorithm getAlgorithm() {
        return Algorithm.HMAC512(jwtSecret);
    }
}
