package it.unisa.emad.feeltheart.configuration.swagger;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class DefaultRouteConfig implements WebMvcConfigurer {

    /**
     * Shows Swagger page on default route on startup.
     * @param registry view's registry.
     */
    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addRedirectViewController("/", "feel-the-art-swagger-ui.html");
    }
}
