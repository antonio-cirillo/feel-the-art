package it.unisa.emad.feeltheart.service;

import it.unisa.emad.feeltheart.dao.QuestionDao;
import it.unisa.emad.feeltheart.dto.question.GetQuestionByTypeRequestDto;
import it.unisa.emad.feeltheart.dto.question.QuestionDto;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Log4j2
@Service
public class QuestionServiceImpl implements QuestionService{

    private final QuestionDao questionDao;

    @Autowired
    public QuestionServiceImpl(QuestionDao questionDao) {
        this.questionDao = questionDao;
    }

    @Override
    public String insertQuestion(QuestionDto request) {
        return null;
    }

    @Override
    public QuestionDto getQuestionById(Long questionId) {
        return null;
    }

    @Override
    public QuestionDto getRandomQuestion() {
        return null;
    }

    @Override
    public List<QuestionDto> getQuestionByType(GetQuestionByTypeRequestDto request) {
        return null;
    }
}
