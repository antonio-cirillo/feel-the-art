package it.unisa.emad.feeltheart.dao;

import it.unisa.emad.feeltheart.dto.question.GetQuestionByTypeRequestDto;
import it.unisa.emad.feeltheart.dto.question.QuestionDto;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Repository;

import java.util.List;

@Log4j2
@Repository(value = "QuestionDaoImpl")
public class QuestionDaoImpl implements QuestionDao{

    @Override
    public void insertQuestion(QuestionDto request) {

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
