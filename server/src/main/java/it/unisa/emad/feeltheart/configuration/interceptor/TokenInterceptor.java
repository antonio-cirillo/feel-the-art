package it.unisa.emad.feeltheart.configuration.interceptor;

import com.fasterxml.jackson.databind.ObjectMapper;
import it.unisa.emad.feeltheart.constant.Constant;
import it.unisa.emad.feeltheart.constant.LogMessage;
import it.unisa.emad.feeltheart.dto.token.GetClaimsFromTokenRequestDto;
import it.unisa.emad.feeltheart.dto.token.ValidateTokenRequestDto;
import it.unisa.emad.feeltheart.exception.TokenException;
import it.unisa.emad.feeltheart.util.FeelTheArtUtils;
import it.unisa.emad.feeltheart.util.TokenUtils;
import lombok.extern.log4j.Log4j2;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.ObjectFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Log4j2
@Component
public class TokenInterceptor implements HandlerInterceptor {

    @Value(value = "${token.enable: false}")
    private String isTokenEnable;

    @Value(value = "${server.servlet.contextPath}")
    private String contextPath;

    private final FeelTheArtUtils feelTheArtUtils;
    private final ObjectFactory<HttpSession> httpSessionObjectFactory;
    private final TokenUtils tokenUtils;

    @Autowired
    public TokenInterceptor(FeelTheArtUtils feelTheArtUtils, ObjectFactory<HttpSession> httpSessionObjectFactory, TokenUtils tokenUtils) {
        this.feelTheArtUtils = feelTheArtUtils;
        this.httpSessionObjectFactory = httpSessionObjectFactory;
        this.tokenUtils = tokenUtils;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        log.info(LogMessage.START);
        log.info("URI: {}", request.getRequestURI());

        if(Boolean.TRUE.toString().equalsIgnoreCase(isTokenEnable)){
            log.info("CHECK TOKEN: TRUE");

            if(contextPath.equalsIgnoreCase(StringUtils.chop(request.getRequestURI()))) {
                log.info("HOME PAGE, SKIP CHECK TOKEN");
                return true;
            }

            Boolean isTokenValid = checkToken(request);
            if(Boolean.FALSE.equals(isTokenValid)){
                sendResponse(response);
                return Boolean.FALSE;
            }

            String deviceId = getDeviceId(request);
            httpSessionObjectFactory.getObject().setAttribute(Constant.KEY_ID_DEVICE, deviceId);

            return Boolean.TRUE;
        }

        log.info("CHECK TOKEN: FALSE");
        log.info(LogMessage.END);
        return Boolean.TRUE;
    }

    private String getDeviceId(HttpServletRequest request) {
        log.info(LogMessage.START);

        String token = request.getHeader(Constant.KEY_TOKEN);

        var getClaimFromTokenRequest = new GetClaimsFromTokenRequestDto(token);
        var getClaimFromTokenResponse = tokenUtils.getClaimsFromToken(getClaimFromTokenRequest);

        if (Boolean.TRUE.equals(getClaimFromTokenResponse.getSuccess())) {
            log.info("Token valid");
            return getClaimFromTokenResponse.getParams().get(Constant.KEY_ID_DEVICE);
        }

        log.warn("Token not valid, details: {}", getClaimFromTokenResponse.getDescription());
        log.info(LogMessage.END);
        throw new TokenException(getClaimFromTokenResponse.getDescription());
    }

    private boolean checkToken(HttpServletRequest request) {
        log.info(LogMessage.START);

        String token = request.getHeader(Constant.KEY_TOKEN);

        var validateTokenRequest = new ValidateTokenRequestDto(token);
        var validateTokenResponse = tokenUtils.validateToken(validateTokenRequest);

        if (Boolean.TRUE.equals(validateTokenResponse.getSuccess())) {
            log.info("Token valid");
            return true;
        }

        log.warn("Token not valid, details: {}", validateTokenResponse.getDescription());
        log.info(LogMessage.END);
        return false;
    }

    private void sendResponse(HttpServletResponse response) throws IOException {
        ObjectMapper mapper = new ObjectMapper();
        String messageResponse = feelTheArtUtils.getMessageResponse(
                Constant.MESSAGE_RESPONSE_VALIDATE_TOKEN_KO);

        response.setContentType(MediaType.APPLICATION_JSON_VALUE);
        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        response.getWriter().write(mapper.writeValueAsString(messageResponse));
    }
}
