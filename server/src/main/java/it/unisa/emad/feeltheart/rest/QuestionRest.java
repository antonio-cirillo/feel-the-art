package it.unisa.emad.feeltheart.rest;

import it.unisa.emad.feeltheart.service.QuestionService;
import it.unisa.emad.feeltheart.util.FeelTheArtUtils;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.ObjectFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;

@Log4j2
@RestController
@RequestMapping(value= "/question")
public class QuestionRest {

    private final FeelTheArtUtils feelTheArtUtils;
    private final ObjectFactory<HttpSession> httpSessionFactory;
    private final QuestionService questionService;

    @Autowired
    public QuestionRest(FeelTheArtUtils feelTheArtUtils, ObjectFactory<HttpSession> httpSessionFactory, QuestionService questionService) {
        this.feelTheArtUtils = feelTheArtUtils;
        this.httpSessionFactory = httpSessionFactory;
        this.questionService = questionService;
    }
}
