package it.unisa.emad.feeltheart.rest;

import com.google.gson.Gson;
import io.swagger.v3.oas.annotations.Operation;
import it.unisa.emad.feeltheart.constant.Constant;
import it.unisa.emad.feeltheart.constant.LogMessage;
import it.unisa.emad.feeltheart.dto.avatar.AddAvatarRequestDto;
import it.unisa.emad.feeltheart.dto.avatar.GeneratedAvatarRequestDto;
import it.unisa.emad.feeltheart.dto.avatar.GeneratedAvatarResponseDto;
import it.unisa.emad.feeltheart.dto.avatar.SetAvatarRequestDto;
import it.unisa.emad.feeltheart.dto.common.ResultDto;
import it.unisa.emad.feeltheart.service.AvatarService;
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

@Log4j2
@RestController
@RequestMapping(value= "/avatar")
public class AvatarRest {

    private final FeelTheArtUtils feelTheArtUtils;
    private final ObjectFactory<HttpSession> httpSessionFactory;
    private final AvatarService avatarService;

    @Autowired
    public AvatarRest(FeelTheArtUtils feelTheArtUtils, ObjectFactory<HttpSession> httpSessionFactory, AvatarService avatarService) {
        this.feelTheArtUtils = feelTheArtUtils;
        this.httpSessionFactory = httpSessionFactory;
        this.avatarService = avatarService;
    }

    @CrossOrigin
    @PostMapping(value = "/1.0/setAvatar", consumes = {MediaType.APPLICATION_JSON_VALUE}, produces = {MediaType.APPLICATION_JSON_VALUE})
    @Operation(description = "Servizio REST utile ad effettuare la modifica dell'avatar di un utente")
    public ResponseEntity<ResultDto<Boolean>> setAvatar(
            @RequestHeader(value = Constant.KEY_LANGUAGE, defaultValue = "IT") String language,
            @RequestBody @Valid SetAvatarRequestDto request) {

        log.info(LogMessage.START);
        log.info(LogMessage.REQUEST, new Gson().toJson(request));

        httpSessionFactory.getObject().setAttribute(Constant.KEY_LANGUAGE, language);

        Boolean result = avatarService.setAvatar(request);
        var response = new ResultDto<Boolean>();

        if(result.equals(Boolean.FALSE)){
            log.info(LogMessage.OPERATION_KO);

            response.setFailureResponse(
                    feelTheArtUtils.getMessageResponse(
                            Constant.MESSAGE_RESPONSE_CODE_OPERATION_KO),
                    HttpStatus.SC_INTERNAL_SERVER_ERROR);

            return ResponseEntity
                    .status(HttpStatus.SC_INTERNAL_SERVER_ERROR)
                    .body(response);
        }

        response.setSuccessTrueResponse(
                feelTheArtUtils.getMessageResponse(Constant.MESSAGE_RESPONSE_CODE_OPERATION_OK));
        response.setData(result);

        log.info(LogMessage.END);
        return ResponseEntity.ok(response);
    }

    @CrossOrigin
    @PostMapping(value = "/1.0/addAvatar", consumes = {MediaType.APPLICATION_JSON_VALUE}, produces = {MediaType.APPLICATION_JSON_VALUE})
    @Operation(description = "Servizio REST utile ad effettuare l'aggiunta di un avatar all'utente")
    public ResponseEntity<ResultDto<Boolean>> addAvatar(
            @RequestHeader(value = Constant.KEY_LANGUAGE, defaultValue = "IT") String language,
            @RequestBody @Valid AddAvatarRequestDto request) {

        log.info(LogMessage.START);
        log.info(LogMessage.REQUEST, new Gson().toJson(request));

        httpSessionFactory.getObject().setAttribute(Constant.KEY_LANGUAGE, language);

        Boolean result = avatarService.addAvatar(request);
        var response = new ResultDto<Boolean>();

        if(result.equals(Boolean.FALSE)){
            log.info(LogMessage.OPERATION_KO);

            response.setFailureResponse(
                    feelTheArtUtils.getMessageResponse(
                            Constant.MESSAGE_RESPONSE_CODE_OPERATION_KO),
                    HttpStatus.SC_INTERNAL_SERVER_ERROR);

            return ResponseEntity
                    .status(HttpStatus.SC_INTERNAL_SERVER_ERROR)
                    .body(response);
        }

        response.setSuccessTrueResponse(
                feelTheArtUtils.getMessageResponse(Constant.MESSAGE_RESPONSE_CODE_OPERATION_OK));
        response.setData(result);

        log.info(LogMessage.END);
        return ResponseEntity.ok(response);
    }

    @CrossOrigin
    @PostMapping(value = "/1.0/generateAvatar", consumes = {MediaType.APPLICATION_JSON_VALUE}, produces = {MediaType.APPLICATION_JSON_VALUE})
    @Operation(description = "Servizio REST utile ad effettuare la generazione di un avatar")
    public ResponseEntity<ResultDto<GeneratedAvatarResponseDto>> generateAvatar(
            @RequestHeader(value = Constant.KEY_LANGUAGE, defaultValue = "IT") String language,
            @RequestBody @Valid GeneratedAvatarRequestDto request) {

        log.info(LogMessage.START);
        log.info(LogMessage.REQUEST, new Gson().toJson(request));

        httpSessionFactory.getObject().setAttribute(Constant.KEY_LANGUAGE, language);

        var result = avatarService.generateAvatar(request);
        var response = new ResultDto<GeneratedAvatarResponseDto>();

        if(null == result){
            log.info(LogMessage.OPERATION_KO);

            response.setFailureResponse(
                    feelTheArtUtils.getMessageResponse(
                            Constant.MESSAGE_RESPONSE_CODE_OPERATION_KO),
                    HttpStatus.SC_INTERNAL_SERVER_ERROR);

            return ResponseEntity
                    .status(HttpStatus.SC_INTERNAL_SERVER_ERROR)
                    .body(response);
        }

        response.setSuccessTrueResponse(
                feelTheArtUtils.getMessageResponse(Constant.MESSAGE_RESPONSE_CODE_OPERATION_OK));
        response.setData(result);

        log.info(LogMessage.END);
        return ResponseEntity.ok(response);
    }
}
