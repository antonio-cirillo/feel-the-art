package it.unisa.emad.feeltheart.rest;

import com.google.gson.Gson;
import io.swagger.v3.oas.annotations.Operation;
import it.unisa.emad.feeltheart.constant.Constant;
import it.unisa.emad.feeltheart.constant.LogMessage;
import it.unisa.emad.feeltheart.dto.card.CardDto;
import it.unisa.emad.feeltheart.dto.card.InsertCardRequestDto;
import it.unisa.emad.feeltheart.dto.common.ResultDto;
import it.unisa.emad.feeltheart.service.CardService;
import it.unisa.emad.feeltheart.util.FeelTheArtUtils;
import lombok.extern.log4j.Log4j2;
import org.apache.http.HttpStatus;
import org.springframework.beans.factory.ObjectFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.List;

@Log4j2
@RestController
@RequestMapping(value= "/card")
public class CardRest {

    private final FeelTheArtUtils feelTheArtUtils;
    private final ObjectFactory<HttpSession> httpSessionFactory;
    private final CardService cardService;

    @Autowired
    public CardRest(FeelTheArtUtils feelTheArtUtils, ObjectFactory<HttpSession> httpSessionFactory, CardService cardService) {
        this.feelTheArtUtils = feelTheArtUtils;
        this.httpSessionFactory = httpSessionFactory;
        this.cardService = cardService;
    }

    @CrossOrigin
    @PutMapping(value = "/1.0/insert-card", consumes = {MediaType.APPLICATION_JSON_VALUE}, produces = {MediaType.APPLICATION_JSON_VALUE})
    @Operation(description = "Servizio REST utile ad effettuare l'inserimento di una carta")
    public ResponseEntity<ResultDto<Long>> insertCard(
            @RequestHeader(value = Constant.KEY_LANGUAGE, defaultValue = "IT") String language,
            @RequestBody @Valid InsertCardRequestDto request) {

        log.info(LogMessage.START);
        log.info(LogMessage.REQUEST, new Gson().toJson(request));

        httpSessionFactory.getObject().setAttribute(Constant.KEY_LANGUAGE, language);

        var result = cardService.insertCard(request);
        var response = new ResultDto<Long>();

        if(null == result){
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
    @GetMapping(value = "/1.0/get-all-cards", produces = {MediaType.APPLICATION_JSON_VALUE})
    @Operation(description = "Servizio REST utile ad effettuare il recupero di tutte le carte")
    public ResponseEntity<ResultDto<List<CardDto>>> getAllCards(
            @RequestHeader(value = Constant.KEY_LANGUAGE, defaultValue = "IT") String language) {

        log.info(LogMessage.START);

        httpSessionFactory.getObject().setAttribute(Constant.KEY_LANGUAGE, language);

        var result = cardService.getAllCards();
        var response = new ResultDto<List<CardDto>>();

        if(result.isEmpty()){
            log.info(LogMessage.CARD_NOT_FOUND);

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
