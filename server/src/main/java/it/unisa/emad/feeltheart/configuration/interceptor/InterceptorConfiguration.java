package it.unisa.emad.feeltheart.configuration.interceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Component
public class InterceptorConfiguration implements WebMvcConfigurer {

    private final LanguageInterceptor languageInterceptor;
    private final TokenInterceptor tokenInterceptor;

    private final List<String> commonPatternsToExclude =
            new ArrayList<>(Arrays.asList(
                    "/",
                    "/**/error",
                    "/**/swagger-ui/favicon-16x16.png",
                    "/**/swagger-ui/favicon-32x32.png",
                    "/**/swagger-ui/swagger-initializer.js",
                    "/**/swagger-ui/index.html",
                    "/**/feel-the-art-swagger-ui/**",
                    "/**/feel-the-art-api-docs",
                    "/**/feel-the-art-api-docs/swagger-config",
                    "/**/feel-the-art-swagger-ui.html"));

    @Autowired
    public InterceptorConfiguration(LanguageInterceptor languageInterceptor, TokenInterceptor tokenInterceptor) {
        this.languageInterceptor = languageInterceptor;
        this.tokenInterceptor = tokenInterceptor;
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry){
        registry
                .addInterceptor(tokenInterceptor)
                .addPathPatterns("/**")
                .excludePathPatterns(commonPatternsToExclude)
                .excludePathPatterns("/**/token/**");

        registry
                .addInterceptor(languageInterceptor)
                .addPathPatterns("/**")
                .excludePathPatterns(commonPatternsToExclude);
    }
}
