package it.unisa.emad.feeltheart.service;

import it.unisa.emad.feeltheart.dto.question.GetQuestionByTypeRequestDto;
import it.unisa.emad.feeltheart.dto.question.InsertQuestionRequestDto;
import it.unisa.emad.feeltheart.dto.question.QuestionDto;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface QuestionService {

    String insertQuestion(InsertQuestionRequestDto request);

    QuestionDto getQuestionById(String questionId);

    QuestionDto getRandomQuestion();

    List<QuestionDto> getQuestionByType(GetQuestionByTypeRequestDto request);
}
