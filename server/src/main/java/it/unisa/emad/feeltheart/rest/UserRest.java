package it.unisa.emad.feeltheart.rest;

import com.google.gson.Gson;
import io.swagger.v3.oas.annotations.Operation;
import it.unisa.emad.feeltheart.constant.Constant;
import it.unisa.emad.feeltheart.constant.LogMessage;
import it.unisa.emad.feeltheart.dto.common.ResultDto;
import it.unisa.emad.feeltheart.dto.user.*;
import it.unisa.emad.feeltheart.service.UserService;
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
@RequestMapping(value= "/user")
public class UserRest {

    private final FeelTheArtUtils feelTheArtUtils;
    private final ObjectFactory<HttpSession> httpSessionFactory;
    private final UserService userService;

    @Autowired
    public UserRest(FeelTheArtUtils feelTheArtUtils, ObjectFactory<HttpSession> httpSessionFactory, UserService userService) {
        this.feelTheArtUtils = feelTheArtUtils;
        this.httpSessionFactory = httpSessionFactory;
        this.userService = userService;
    }

    @CrossOrigin
    @PutMapping(value = "/1.0/insertUser", consumes = {MediaType.APPLICATION_JSON_VALUE}, produces = {MediaType.APPLICATION_JSON_VALUE})
    @Operation(description = "Servizio REST utile ad effettuare l'inserimento di un utente")
    public ResponseEntity<ResultDto<String>> insertUser(
            @RequestHeader(value = Constant.KEY_LANGUAGE, defaultValue = "IT") String language,
            @RequestBody @Valid InsertUserRequestDto request) {

        log.info(LogMessage.START);
        log.info(LogMessage.REQUEST, new Gson().toJson(request));

        httpSessionFactory.getObject().setAttribute(Constant.KEY_LANGUAGE, language);

        var result = userService.insertUser(request);
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
    @GetMapping(value = "/1.0/getUserByDeviceId", produces = {MediaType.APPLICATION_JSON_VALUE})
    @Operation(description = "Servizio REST utile ad effettuare il recupero di un utente")
    public ResponseEntity<ResultDto<UserDto>> getUserByDeviceId(
            @RequestHeader(value = Constant.KEY_LANGUAGE, defaultValue = "IT") String language,
            @RequestParam @NotBlank(message = "Campo id_device non valorizzato") String device_id) {

        log.info(LogMessage.START);

        httpSessionFactory.getObject().setAttribute(Constant.KEY_LANGUAGE, language);

        var userToRecover = userService.getUserByDeviceId(device_id);
        var response = new ResultDto<UserDto>();

        if(null == userToRecover){
            log.info(LogMessage.USER_NOT_FOUND);

            response.setSuccessFalseResponse(
                    feelTheArtUtils.getMessageResponse(Constant.MESSAGE_RESPONSE_FOUND_KO));

            return ResponseEntity
                    .status(HttpStatus.SC_OK)
                    .body(response);
        }

        response.setSuccessTrueResponse(
                feelTheArtUtils.getMessageResponse(
                        Constant.MESSAGE_RESPONSE_CODE_OPERATION_OK));
        response.setData(userToRecover);

        log.info(LogMessage.END);
        return ResponseEntity.ok(response);
    }

    @CrossOrigin
    @PutMapping(value = "/1.0/initializeUser", consumes = {MediaType.APPLICATION_JSON_VALUE}, produces = {MediaType.APPLICATION_JSON_VALUE})
    @Operation(description = "Servizio REST utile ad effettuare l'inizializzazione di un utente")
    public ResponseEntity<ResultDto<InitializeUserResponseDto>> initializeUser(
            @RequestHeader(value = Constant.KEY_LANGUAGE, defaultValue = "IT") String language,
            @RequestBody @Valid InitializeUserRequestDto request) {

        log.info(LogMessage.START);
        log.info(LogMessage.REQUEST, new Gson().toJson(request));

        httpSessionFactory.getObject().setAttribute(Constant.KEY_LANGUAGE, language);

        var result = userService.initializeUser(request);
        var response = new ResultDto<InitializeUserResponseDto>();

        if(null == result){
            log.info(LogMessage.OPERATION_KO);

            response.setFailureResponse(
                    feelTheArtUtils.getMessageResponse(Constant.MESSAGE_RESPONSE_CODE_OPERATION_KO),
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
    @PostMapping(value = "/1.0/updateUser", consumes = {MediaType.APPLICATION_JSON_VALUE}, produces = {MediaType.APPLICATION_JSON_VALUE})
    @Operation(description = "Servizio REST utile ad effettuare la modifica di un utente")
    public ResponseEntity<ResultDto<Boolean>> updateUser(
            @RequestHeader(value = Constant.KEY_LANGUAGE, defaultValue = "IT") String language,
            @RequestBody @Valid UserDto request) {

        log.info(LogMessage.START);
        log.info(LogMessage.REQUEST, new Gson().toJson(request));

        httpSessionFactory.getObject().setAttribute(Constant.KEY_LANGUAGE, language);

        var result = userService.updateUser(request);
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
                feelTheArtUtils.getMessageResponse(
                        Constant.MESSAGE_RESPONSE_CODE_OPERATION_OK));
        response.setData(result);

        log.info(LogMessage.END);
        return ResponseEntity.ok(response);
    }

    @CrossOrigin
    @PostMapping(value = "/1.0/getLeaderboard", consumes = {MediaType.APPLICATION_JSON_VALUE}, produces = {MediaType.APPLICATION_JSON_VALUE})
    @Operation(description = "Servizio REST utile ad effettuare il recupero della classifica degli utenti")
    public ResponseEntity<ResultDto<List<UserDto>>> getLeaderboard(
            @RequestHeader(value = Constant.KEY_LANGUAGE, defaultValue = "IT") String language,
            @RequestBody @Valid GetLeaderboardRequestDto request) {

        log.info(LogMessage.START);
        log.info(LogMessage.REQUEST, new Gson().toJson(request));

        httpSessionFactory.getObject().setAttribute(Constant.KEY_LANGUAGE, language);

        var result = userService.getLeaderboard(request);
        var response = new ResultDto<List<UserDto>>();

        if(result.isEmpty()){
            log.info(LogMessage.USER_NOT_FOUND);

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
