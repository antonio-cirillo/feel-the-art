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
import org.apache.http.HttpStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@Log4j2
@RestController
@RequestMapping(value= "/user")
public class UserRest {

    private final FeelTheArtUtils feelTheArtUtils;
    private final UserService userService;

    @Autowired
    public UserRest(FeelTheArtUtils feelTheArtUtils, UserService userService) {
        this.feelTheArtUtils = feelTheArtUtils;
        this.userService = userService;
    }

    @CrossOrigin
    @GetMapping(value = "/1.0/get-user-by-device-id", produces = {MediaType.APPLICATION_JSON_VALUE})
    @Operation(description = "Servizio REST utile ad effettuare il recupero di un utente")
    public ResponseEntity<ResultDto<UserDto>> getUserByDeviceId(
            @RequestHeader(value = Constant.KEY_LANGUAGE, defaultValue = "IT") String language,
            @RequestHeader(value = Constant.KEY_TOKEN, defaultValue = "") String token) {

        log.info(LogMessage.START);

        var userToRecover = userService.getUserByDeviceId(feelTheArtUtils.getDeviceId());
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
    @PostMapping(value = "/1.0/update-user", consumes = {MediaType.APPLICATION_JSON_VALUE}, produces = {MediaType.APPLICATION_JSON_VALUE})
    @Operation(description = "Servizio REST utile ad effettuare la modifica di un utente")
    public ResponseEntity<ResultDto<Boolean>> updateUser(
            @RequestHeader(value = Constant.KEY_LANGUAGE, defaultValue = "IT") String language,
            @RequestHeader(value = Constant.KEY_TOKEN, defaultValue = "") String token,
            @RequestBody @Valid UserDto request) {

        log.info(LogMessage.START);
        log.info(LogMessage.REQUEST, new Gson().toJson(request));

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
    @PostMapping(value = "/1.0/get-leaderboard", consumes = {MediaType.APPLICATION_JSON_VALUE}, produces = {MediaType.APPLICATION_JSON_VALUE})
    @Operation(description = "Servizio REST utile ad effettuare il recupero della classifica degli utenti")
    public ResponseEntity<ResultDto<List<UserDto>>> getLeaderboard(
            @RequestHeader(value = Constant.KEY_LANGUAGE, defaultValue = "IT") String language,
            @RequestHeader(value = Constant.KEY_TOKEN, defaultValue = "") String token,
            @RequestBody @Valid GetLeaderboardRequestDto request) {

        log.info(LogMessage.START);
        log.info(LogMessage.REQUEST, new Gson().toJson(request));

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

    @CrossOrigin
    @PutMapping(value = "/1.0/register-user", consumes = {MediaType.APPLICATION_JSON_VALUE}, produces = {MediaType.APPLICATION_JSON_VALUE})
    @Operation(description = "Servizio REST utile ad effettuare l'inserimento di un utente")
    public ResponseEntity<ResultDto<RegisterUserResponseDto>> registerUser(
            @RequestHeader(value = Constant.KEY_LANGUAGE, defaultValue = "IT") String language,
            @RequestBody @Valid RegisterUserRequestDto request) {

        log.info(LogMessage.START);
        log.info(LogMessage.REQUEST, new Gson().toJson(request));

        var result = userService.registerUser(request);
        var response = new ResultDto<RegisterUserResponseDto>();

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
    @PostMapping(value = "/1.0/login-user", consumes = {MediaType.APPLICATION_JSON_VALUE}, produces = {MediaType.APPLICATION_JSON_VALUE})
    @Operation(description = "Servizio REST utile ad effettuare l'inserimento di un utente")
    public ResponseEntity<ResultDto<LoginUserResponseDto>> loginUser(
            @RequestHeader(value = Constant.KEY_LANGUAGE, defaultValue = "IT") String language,
            @RequestBody @Valid LoginUserRequestDto request) {

        log.info(LogMessage.START);
        log.info(LogMessage.REQUEST, new Gson().toJson(request));

        var result = userService.loginUser(request);
        var response = new ResultDto<LoginUserResponseDto>();

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
}
