package it.unisa.emad.feeltheart.service;

import it.unisa.emad.feeltheart.constant.LogMessage;
import it.unisa.emad.feeltheart.dao.QuestionDao;
import it.unisa.emad.feeltheart.dto.question.GetQuestionByTypeRequestDto;
import it.unisa.emad.feeltheart.dto.question.InsertQuestionRequestDto;
import it.unisa.emad.feeltheart.dto.question.QuestionDto;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collections;
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
    public String insertQuestion(InsertQuestionRequestDto request) {
        log.info(LogMessage.START);

        try{
            String questionId = questionDao.insertQuestion(request);

            log.info(LogMessage.END);
            return  questionId;
        } catch (InterruptedException e){
            log.warn(LogMessage.INTERRUPTED_EXCEPTION, e.getMessage());
            Thread.currentThread().interrupt();
            return null;
        }
        catch (Exception e){
            log.error(LogMessage.ERROR, e.getMessage());
            return null;
        }
    }

    @Override
    public QuestionDto getQuestionById(String questionId) {
        log.info(LogMessage.START);

        try {
            QuestionDto questionToRecover = questionDao.getQuestionById(questionId);

            log.info(LogMessage.END);
            return questionToRecover;
        }
        catch (InterruptedException e){
            log.warn(LogMessage.INTERRUPTED_EXCEPTION, e.getMessage());
            Thread.currentThread().interrupt();
            return null;
        }
        catch (Exception e){
            log.error(LogMessage.ERROR, e.getMessage());
            return null;
        }
    }

    @Override
    public QuestionDto getRandomQuestion() {
        log.info(LogMessage.START);

        try {
            QuestionDto questionToRecover = questionDao.getRandomQuestion();

            log.info(LogMessage.END);
            return questionToRecover;
        }
        catch (InterruptedException e){
            log.warn(LogMessage.INTERRUPTED_EXCEPTION, e.getMessage());
            Thread.currentThread().interrupt();
            return null;
        }
        catch (Exception e){
            log.error(LogMessage.ERROR, e.getMessage());
            return null;
        }
    }

    @Override
    public List<QuestionDto> getQuestionByType(GetQuestionByTypeRequestDto request) {
        log.info(LogMessage.START);

        try {
            List<QuestionDto> result = questionDao.getQuestionByType(request);

            log.info(LogMessage.END);
            return result;
        } catch (InterruptedException e){
            log.warn(LogMessage.INTERRUPTED_EXCEPTION, e.getMessage());
            Thread.currentThread().interrupt();
            return Collections.emptyList();
        }
        catch (Exception e){
            log.error(LogMessage.ERROR, e.getMessage());
            return Collections.emptyList();
        }
    }
}
