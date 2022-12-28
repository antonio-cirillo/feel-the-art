package it.unisa.emad.feeltheart.dao;

import it.unisa.emad.feeltheart.dto.question.GetQuestionByTypeRequestDto;
import it.unisa.emad.feeltheart.dto.question.InsertQuestionRequestDto;
import it.unisa.emad.feeltheart.dto.question.QuestionDto;
import org.springframework.stereotype.Repository;

import java.security.NoSuchAlgorithmException;
import java.util.List;
import java.util.concurrent.ExecutionException;

@Repository
public interface QuestionDao {

    String insertQuestion(InsertQuestionRequestDto request) throws ExecutionException, InterruptedException;

    QuestionDto getQuestionById(String questionId) throws ExecutionException, InterruptedException;

    QuestionDto getRandomQuestion() throws ExecutionException, InterruptedException, NoSuchAlgorithmException;

    List<QuestionDto> getQuestionByType(GetQuestionByTypeRequestDto request) throws ExecutionException, InterruptedException;
}
