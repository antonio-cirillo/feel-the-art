package it.unisa.emad.feeltheart.rest;

import com.google.gson.Gson;
import io.swagger.v3.oas.annotations.Operation;
import it.unisa.emad.feeltheart.constant.Constant;
import it.unisa.emad.feeltheart.constant.LogMessage;
import it.unisa.emad.feeltheart.dto.common.ResultDto;
import it.unisa.emad.feeltheart.dto.question.InsertQuestionRequestDto;
import it.unisa.emad.feeltheart.dto.token.*;
import it.unisa.emad.feeltheart.util.FeelTheArtUtils;
import it.unisa.emad.feeltheart.util.TokenUtils;
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

@Log4j2
@RestController
@RequestMapping(value= "/token")
public class TokenRest {

    private final FeelTheArtUtils feelTheArtUtils;
    private final ObjectFactory<HttpSession> httpSessionFactory;
    private final TokenUtils tokenUtils;

    @Autowired
    public TokenRest(FeelTheArtUtils feelTheArtUtils, ObjectFactory<HttpSession> httpSessionFactory, TokenUtils tokenUtils) {
        this.feelTheArtUtils = feelTheArtUtils;
        this.httpSessionFactory = httpSessionFactory;
        this.tokenUtils = tokenUtils;
    }

    @CrossOrigin
    @PostMapping(value = "/1.0/generate-token", consumes = {MediaType.APPLICATION_JSON_VALUE}, produces = {MediaType.APPLICATION_JSON_VALUE})
    @Operation(description = "")
    public ResponseEntity<ResultDto<GenerateTokenResponseDto>> generateToken(
            @RequestHeader(value = Constant.KEY_LANGUAGE, defaultValue = "IT") String language,
            @RequestBody @Valid GenerateTokenRequestDto request) {

        log.info(LogMessage.START);
        log.info(LogMessage.REQUEST, new Gson().toJson(request));

        httpSessionFactory.getObject().setAttribute(Constant.KEY_LANGUAGE, language);

        var result = tokenUtils.generateToken(request);
        var response = new ResultDto<GenerateTokenResponseDto>();

        if(Boolean.FALSE.equals(result.getSuccess())){
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
    @PostMapping(value = "/1.0/validate-token", consumes = {MediaType.APPLICATION_JSON_VALUE}, produces = {MediaType.APPLICATION_JSON_VALUE})
    @Operation(description = "")
    public ResponseEntity<ResultDto<ValidateTokenResponseDto>> validateToken(
            @RequestHeader(value = Constant.KEY_LANGUAGE, defaultValue = "IT") String language,
            @RequestBody @Valid ValidateTokenRequestDto request) {

        log.info(LogMessage.START);
        log.info(LogMessage.REQUEST, new Gson().toJson(request));

        httpSessionFactory.getObject().setAttribute(Constant.KEY_LANGUAGE, language);

        var result = tokenUtils.validateToken(request);
        var response = new ResultDto<ValidateTokenResponseDto>();

        if(Boolean.FALSE.equals(result.getSuccess())){
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
    @PostMapping(value = "/1.0/refresh-token", consumes = {MediaType.APPLICATION_JSON_VALUE}, produces = {MediaType.APPLICATION_JSON_VALUE})
    @Operation(description = "")
    public ResponseEntity<ResultDto<RefreshTokenResponseDto>> refreshToken(
            @RequestHeader(value = Constant.KEY_LANGUAGE, defaultValue = "IT") String language,
            @RequestBody @Valid RefreshTokenRequestDto request) {

        log.info(LogMessage.START);
        log.info(LogMessage.REQUEST, new Gson().toJson(request));

        httpSessionFactory.getObject().setAttribute(Constant.KEY_LANGUAGE, language);

        var result = tokenUtils.refreshToken(request);
        var response = new ResultDto<RefreshTokenResponseDto>();

        if(Boolean.FALSE.equals(result.getSuccess())){
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
    @PostMapping(value = "/1.0/get-claim-from-token", consumes = {MediaType.APPLICATION_JSON_VALUE}, produces = {MediaType.APPLICATION_JSON_VALUE})
    @Operation(description = "")
    public ResponseEntity<ResultDto<GetClaimsFromTokenResponseDto>> getClaimFromToken(
            @RequestHeader(value = Constant.KEY_LANGUAGE, defaultValue = "IT") String language,
            @RequestBody @Valid GetClaimsFromTokenRequestDto request) {

        log.info(LogMessage.START);
        log.info(LogMessage.REQUEST, new Gson().toJson(request));

        httpSessionFactory.getObject().setAttribute(Constant.KEY_LANGUAGE, language);

        var result = tokenUtils.getClaimsFromToken(request);
        var response = new ResultDto<GetClaimsFromTokenResponseDto>();

        if(Boolean.FALSE.equals(result.getSuccess())){
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
