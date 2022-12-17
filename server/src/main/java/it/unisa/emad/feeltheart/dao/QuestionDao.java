package it.unisa.emad.feeltheart.dao;

import it.unisa.emad.feeltheart.dto.question.GetQuestionByTypeRequestDto;
import it.unisa.emad.feeltheart.dto.question.QuestionDto;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface QuestionDao {

    void insertQuestion(QuestionDto request);

    QuestionDto getQuestionById(Long questionId);

    QuestionDto getRandomQuestion();

    List<QuestionDto> getQuestionByType(GetQuestionByTypeRequestDto request);
}
