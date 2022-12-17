package it.unisa.emad.feeltheart.service;

import it.unisa.emad.feeltheart.dto.question.GetQuestionByTypeRequestDto;
import it.unisa.emad.feeltheart.dto.question.QuestionDto;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface QuestionService {

    String insertQuestion(QuestionDto request);

    QuestionDto getQuestionById(Long questionId);

    QuestionDto getRandomQuestion();

    List<QuestionDto> getQuestionByType(GetQuestionByTypeRequestDto request);
}
