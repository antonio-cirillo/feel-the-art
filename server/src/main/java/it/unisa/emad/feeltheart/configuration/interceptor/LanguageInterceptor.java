package it.unisa.emad.feeltheart.configuration.interceptor;

import it.unisa.emad.feeltheart.constant.Constant;
import it.unisa.emad.feeltheart.constant.LogMessage;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.ObjectFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Log4j2
@Component
public class LanguageInterceptor implements HandlerInterceptor {

    private final ObjectFactory<HttpSession> httpSessionObjectFactory;

    @Autowired
    public LanguageInterceptor(ObjectFactory<HttpSession> httpSessionObjectFactory) {
        this.httpSessionObjectFactory = httpSessionObjectFactory;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception{
        log.info(LogMessage.START);

        String language = request.getHeader(Constant.KEY_LANGUAGE);
        httpSessionObjectFactory.getObject().setAttribute(Constant.KEY_LANGUAGE, language);

        log.info(LogMessage.END);
        return true;
    }
}
