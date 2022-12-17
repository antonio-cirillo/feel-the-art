package it.unisa.emad.feeltheart.rest;

import com.google.gson.Gson;
import io.swagger.v3.oas.annotations.Operation;
import it.unisa.emad.feeltheart.constant.Constant;
import it.unisa.emad.feeltheart.constant.LogMessage;
import it.unisa.emad.feeltheart.dto.common.ResultDto;
import it.unisa.emad.feeltheart.dto.question.GetQuestionByTypeRequestDto;
import it.unisa.emad.feeltheart.dto.question.InsertQuestionRequestDto;
import it.unisa.emad.feeltheart.dto.question.QuestionDto;
import it.unisa.emad.feeltheart.service.QuestionService;
import it.unisa.emad.feeltheart.util.FeelTheArtUtils;
import lombok.extern.log4j.Log4j2;
import org.apache.commons.lang3.StringUtils;
import org.apache.http.HttpStatus;
import org.springframework.beans.factory.ObjectFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import java.util.List;

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

    @CrossOrigin
    @PutMapping(value = "/1.0/insert-question", consumes = {MediaType.APPLICATION_JSON_VALUE}, produces = {MediaType.APPLICATION_JSON_VALUE})
    @Operation(description = "Servizio REST utile ad effettuare l'inserimento di una domanda")
    public ResponseEntity<ResultDto<String>> insertQuestion(
            @RequestHeader(value = Constant.KEY_LANGUAGE, defaultValue = "IT") String language,
            @RequestBody @Valid InsertQuestionRequestDto request) {

        log.info(LogMessage.START);
        log.info(LogMessage.REQUEST, new Gson().toJson(request));

        httpSessionFactory.getObject().setAttribute(Constant.KEY_LANGUAGE, language);

        var result = questionService.insertQuestion(request);
        var response = new ResultDto<String>();

        if(StringUtils.isBlank(result)){
            response.setFailureResponse(
                    feelTheArtUtils.getMessageResponse(
                            Constant.MESSAGE_RESPONSE_CODE_OPERATION_KO),
                    HttpStatus.SC_INTERNAL_SERVER_ERROR);

            return ResponseEntity
                    .status(HttpStatus.SC_INTERNAL_SERVER_ERROR)
                    .body(response);
        }

        response.setSuccessTrueResponse(
                feelTheArtUtils.getMessageResponse(
                        Constant.MESSAGE_RESPONSE_CODE_OPERATION_OK));
        response.setData(result);

        log.info(LogMessage.END);
        return ResponseEntity.ok(response);
    }

    @CrossOrigin
    @GetMapping(value = "/1.0/get-question-by-id", produces = {MediaType.APPLICATION_JSON_VALUE})
    @Operation(description = "Servizio REST utile ad effettuare il recupero di una domanda")
    public ResponseEntity<ResultDto<QuestionDto>> getQuestionById(
            @RequestHeader(value = Constant.KEY_LANGUAGE, defaultValue = "IT") String language,
            @RequestParam(value = "id_question") @NotBlank(message = "Campo id_question non valorizzato") String questionId) {

        log.info(LogMessage.START);

        httpSessionFactory.getObject().setAttribute(Constant.KEY_LANGUAGE, language);

        var questionToRecover = questionService.getQuestionById(questionId);
        var response = new ResultDto<QuestionDto>();

        if(null == questionToRecover){
            log.info(LogMessage.QUESTION_NOT_FOUND);

            response.setSuccessFalseResponse(
                    feelTheArtUtils.getMessageResponse(Constant.MESSAGE_RESPONSE_FOUND_KO));

            return ResponseEntity
                    .status(HttpStatus.SC_OK)
                    .body(response);
        }

        response.setSuccessTrueResponse(
                feelTheArtUtils.getMessageResponse(
                        Constant.MESSAGE_RESPONSE_CODE_OPERATION_OK));
        response.setData(questionToRecover);

        log.info(LogMessage.END);
        return ResponseEntity.ok(response);
    }

    @CrossOrigin
    @GetMapping(value = "/1.0/get-random-question", produces = {MediaType.APPLICATION_JSON_VALUE})
    @Operation(description = "Servizio REST utile ad effettuare il recupero di una domanda casuale")
    public ResponseEntity<ResultDto<QuestionDto>> getRandomQuestion(
            @RequestHeader(value = Constant.KEY_LANGUAGE, defaultValue = "IT") String language) {

        log.info(LogMessage.START);

        httpSessionFactory.getObject().setAttribute(Constant.KEY_LANGUAGE, language);

        var questionToRecover = questionService.getRandomQuestion();
        var response = new ResultDto<QuestionDto>();

        if(null == questionToRecover){
            log.info(LogMessage.QUESTION_NOT_FOUND);

            response.setSuccessFalseResponse(
                    feelTheArtUtils.getMessageResponse(Constant.MESSAGE_RESPONSE_FOUND_KO));

            return ResponseEntity
                    .status(HttpStatus.SC_OK)
                    .body(response);
        }

        response.setSuccessTrueResponse(
                feelTheArtUtils.getMessageResponse(
                        Constant.MESSAGE_RESPONSE_CODE_OPERATION_OK));
        response.setData(questionToRecover);

        log.info(LogMessage.END);
        return ResponseEntity.ok(response);
    }

    @CrossOrigin
    @PostMapping(value = "/1.0/get-question-by-type", consumes = {MediaType.APPLICATION_JSON_VALUE}, produces = {MediaType.APPLICATION_JSON_VALUE})
    @Operation(description = "Servizio REST utile ad effettuare il recupero della classifica degli utenti")
    public ResponseEntity<ResultDto<List<QuestionDto>>> getQuestionByType(
            @RequestHeader(value = Constant.KEY_LANGUAGE, defaultValue = "IT") String language,
            @RequestBody @Valid GetQuestionByTypeRequestDto request) {

        log.info(LogMessage.START);
        log.info(LogMessage.REQUEST, new Gson().toJson(request));

        httpSessionFactory.getObject().setAttribute(Constant.KEY_LANGUAGE, language);

        var result = questionService.getQuestionByType(request);
        var response = new ResultDto<List<QuestionDto>>();

        if(result.isEmpty()){
            log.info(LogMessage.QUESTION_NOT_FOUND);

            response.setSuccessFalseResponse(
                    feelTheArtUtils.getMessageResponse(Constant.MESSAGE_RESPONSE_FOUND_KO));

            return ResponseEntity
                    .status(HttpStatus.SC_OK)
                    .body(response);
        }

        response.setSuccessTrueResponse(
                feelTheArtUtils.getMessageResponse(
                        Constant.MESSAGE_RESPONSE_CODE_OPERATION_OK));
        response.setData(result);

        log.info(LogMessage.END);
        return ResponseEntity.ok(response);
    }
}
