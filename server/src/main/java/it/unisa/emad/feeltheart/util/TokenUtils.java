package it.unisa.emad.feeltheart.util;

import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTCreator.Builder;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTDecodeException;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.auth0.jwt.exceptions.TokenExpiredException;
import com.auth0.jwt.interfaces.Claim;
import it.unisa.emad.feeltheart.constant.LogMessage;
import it.unisa.emad.feeltheart.dto.token.*;
import lombok.extern.log4j.Log4j2;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

@Log4j2
@Component
public class TokenUtils {

    @Value(value = "${token.oauth2.jwtsecret}")
    private String jwtSecret;

    @Value(value = "${token.oauth2.jwtduration.minutes}")
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
    private static byte[] key;
    private final DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    public GenerateTokenResponseDto generateToken(GenerateTokenRequestDto request) {
        log.info(LogMessage.START);

        var response = new GenerateTokenResponseDto();
        var oauth2 = new Oauth2Dto();

        try {
            Algorithm alg = Algorithm.HMAC256(jwtSecret);
            Date expirationDate = getExpireDate();

            Builder token = JWT.create();

            Map<String, String> params = request.getParams();
            if(null != params && !params.isEmpty()) {
                params.forEach(token::withClaim);
            }

            String stringToken = token
                    .withIssuer(issuer)
                    .withIssuedAt(new Date(System.currentTimeMillis()))
                    .withExpiresAt(expirationDate)
                    .sign(alg);

            String encryptedToken = encryptToken(stringToken);
            if(StringUtils.isBlank(encryptedToken)) {
                log.error("Errore nella cifratura del token");
                response.error("Errore durante la cifratura del token");
                return response;
            }

            oauth2.setAccess_token(encryptedToken);
            oauth2.setExpires_at(dateFormat.format(expirationDate));
            oauth2.setToken_type(tokenType);

            response.setToken(oauth2);
            response.setSuccess(true);
            response.setDescription("Token generato correttamente");
        } catch (Exception e) {
            log.error(LogMessage.ERROR, e.getMessage());
            response.error("Token non generato a causa di un errore generale");
            return response;
        }

        log.info(LogMessage.END);
        return response;
    }

    public ValidateTokenResponseDto validateToken(ValidateTokenRequestDto request) {
        log.info(LogMessage.START);

        var result = new ValidateTokenResponseDto();
        String encryptedToken = request.getToken();

        try {
            String token = decryptToken(encryptedToken);
            if(StringUtils.isBlank(token)) {
                log.error("Errore durante la decifrazione del token");
                result.error("Errore durante la decifrazione del token");
                return result;
            }

            Algorithm alg = Algorithm.HMAC512(jwtSecret);
            JWTVerifier verifier = JWT.require(alg)
                    .withIssuer(issuer)
                    .build();

            verifier.verify(token);

            result.setSuccess(true);
            result.setDescription("Token valido");
        }
        catch (TokenExpiredException tee) {
            log.info("TOKEN SCADUTO");
            result.error("Token scaduto");
        }
        catch (JWTVerificationException jve) {
            log.info("TOKEN NON VALIDO");
            result.error("Token non valido");
        }
        catch (Exception e) {
            log.info("Errore: {}", e.getMessage());
            result.error("Errore generico");
        }

        log.info(LogMessage.END);
        return result;
    }

    public RefreshTokenResponseDto refreshToken(RefreshTokenRequestDto request) {
        log.info("START");

        var response = new RefreshTokenResponseDto();
        var oauth2 = new Oauth2Dto();

        String encryptedToken = request.getToken();

        try {
            String token = decryptToken(encryptedToken);
            if(StringUtils.isBlank(token)) {
                log.error("Errore durante la decifratura del token");
                response.error("Errore durante la decifratura del token");
                return response;
            }

            Date expirationDate = getExpireDate();
            Algorithm alg = Algorithm.HMAC512(jwtSecret);
            Builder refreshToken = JWT.create();

            Map<String, Claim> claims = JWT.decode(token).getClaims();
            if(null != claims && !claims.isEmpty()) {
                claims.forEach((k, v) ->{
                    if (Objects.nonNull(v.asString())) {
                        refreshToken.withClaim(k, v.asString());
                    } else {
                        refreshToken.withClaim(k, v.asInt());
                    }
                });
            }

            String stringRefreshToken = refreshToken
                    .withIssuer(issuer)
                    .withIssuedAt(new Date(System.currentTimeMillis()))
                    .withExpiresAt(expirationDate)
                    .sign(alg);

            String encryptedRefreshToken = encryptToken(stringRefreshToken);
            if(StringUtils.isBlank(encryptedRefreshToken)) {
                log.error("Errore nella criptazione del token");
                response.error("Errore durante la criptazione del token");
                return response;
            }

            oauth2.setAccess_token(encryptedRefreshToken);
            oauth2.setExpires_at(dateFormat.format(getExpireDate()));
            oauth2.setToken_type(tokenType);

            response.setToken(oauth2);
            response.setSuccess(true);
            response.setDescription("Token aggiornato con successo");
        } catch (Exception e) {
            log.error(LogMessage.ERROR, e.getMessage());
            response.error("Errore");
        }

        log.info(LogMessage.END);
        return response;
    }

    public GetClaimsFromTokenResponseDto getClaimsFromToken(GetClaimsFromTokenRequestDto request) {
        var result = new GetClaimsFromTokenResponseDto();

        if (request == null || request.getToken() == null) {
            result.error("Token assente");
            return result;
        }

        var validationResult = this.validateToken(
                new ValidateTokenRequestDto(request.getToken())
        );
        if (!validationResult.getSuccess()) {
            result.error(validationResult.getDescription());
            return result;
        }

        try {
            String decryptToken = this.decryptToken(request.getToken());
            if(StringUtils.isBlank(decryptToken)){
                //TODO:
                return null;
            }
            var token = JWT.decode(decryptToken);

            Map<String, String> params = new HashMap<>();
            token.getClaims().forEach((k, v) -> params.put(k, v.asString()));

            result.setParams(params);
            result.setDescription("");
            result.setSuccess(Boolean.TRUE);

        } catch (JWTDecodeException e) {
            log.warn(e.getMessage());
            result.error("Errore nella decodifica del token.");
        }

        log.info(LogMessage.END);
        return result;
    }



    private String encryptToken(String token) {
        try{
            setKey(secret);
            Cipher cipher = Cipher.getInstance(algorithm);
            cipher.init(Cipher.ENCRYPT_MODE, secretKey);
            return Base64.getEncoder().encodeToString(cipher.doFinal(token.getBytes(StandardCharsets.UTF_8)));
        }catch (Exception e) {
            log.error(LogMessage.ERROR + e.getMessage());
            return null;
        }
    }

    private String decryptToken(String strToDecrypt) {
        try{
            setKey(secret);
            Cipher cipher = Cipher.getInstance(algorithm);
            cipher.init(Cipher.DECRYPT_MODE, secretKey);

            return new String(cipher.doFinal(Base64.getDecoder().decode(strToDecrypt)));
        }
        catch (Exception e) {
            log.error(LogMessage.ERROR + e.getMessage());
            return null;
        }
    }

    private void setKey(String secret) {
        MessageDigest messageDigest;
        try {
            key = secret.getBytes(StandardCharsets.UTF_8);
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
}
