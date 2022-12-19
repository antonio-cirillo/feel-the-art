package it.unisa.emad.feeltheart.util;

import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTCreator.Builder;
import com.auth0.jwt.algorithms.Algorithm;
import it.unisa.emad.feeltheart.constant.LogMessage;
import it.unisa.emad.feeltheart.dto.token.GenerateTokenRequestDto;
import it.unisa.emad.feeltheart.dto.token.GenerateTokenResponseDto;
import it.unisa.emad.feeltheart.dto.token.Oauth2Dto;
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
import java.util.Arrays;
import java.util.Base64;
import java.util.Date;
import java.util.Map;

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
            response.error("Errore: " + e.getMessage());
            return response;
        }

        log.info(LogMessage.END);
        return response;
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
