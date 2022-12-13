package it.unisa.emad.feeltheart.configuration.advice;

import it.unisa.emad.feeltheart.constant.Constant;
import it.unisa.emad.feeltheart.constant.LogMessage;
import it.unisa.emad.feeltheart.dto.common.ResultDto;
import it.unisa.emad.feeltheart.util.FeelTheArtUtils;
import lombok.extern.log4j.Log4j2;
import org.apache.commons.lang3.StringUtils;
import org.apache.http.HttpStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import javax.validation.ConstraintViolationException;
import javax.validation.ElementKind;

@Log4j2
@ControllerAdvice
public class ApplicationExceptionHandler {

    private final FeelTheArtUtils feelTheArtUtils;

    @Autowired
    public ApplicationExceptionHandler(FeelTheArtUtils feelTheArtUtils) {
        this.feelTheArtUtils = feelTheArtUtils;
    }

    @ExceptionHandler(value = {MethodArgumentNotValidException.class})
    public ResponseEntity<ResultDto<String>> handleInvalidArguments(MethodArgumentNotValidException e){
        log.info(LogMessage.START);
        log.info(LogMessage.EXCEPTION_CAPTURED, e.getMessage());

        StringBuilder errorMessageBuilder = new StringBuilder(
                feelTheArtUtils.getMessageResponse(Constant.MESSAGE_RESPONSE_CODE_FIELDS_NOT_VALID));

        e.getBindingResult()
                .getFieldErrors()
                .forEach(error ->
                        errorMessageBuilder
                                .append(error.getField())
                                .append(Constant.SEPARATOR));

        String errorMessage = deleteLastSeparator(errorMessageBuilder.toString());

        var response = new ResultDto<String>();
        response.setFailureResponse(errorMessage, HttpStatus.SC_BAD_REQUEST);

        log.info(LogMessage.END_BAD_REQUEST, errorMessage);
        return ResponseEntity.status(HttpStatus.SC_BAD_REQUEST).body(response);
    }

    @ExceptionHandler(value = {ConstraintViolationException.class})
    public ResponseEntity<ResultDto<String>> handleInvalidArguments(ConstraintViolationException e){
        log.info(LogMessage.START);
        log.info(LogMessage.EXCEPTION_CAPTURED, e.getMessage());

        StringBuilder errorMessageBuilder = new StringBuilder(
                feelTheArtUtils.getMessageResponse(Constant.MESSAGE_RESPONSE_CODE_FIELDS_NOT_VALID));

        if(!e.getConstraintViolations().isEmpty()){
            e.getConstraintViolations()
                    .forEach(error -> {
                        error.getPropertyPath().forEach(node -> {
                            if((ElementKind.PROPERTY.equals(node.getKind())
                                        || ElementKind.PARAMETER.equals(node.getKind()))
                                    && !node.getName().equals("request"))
                                errorMessageBuilder.append(node.getName());
                        });
                        errorMessageBuilder.append(Constant.SEPARATOR);
                    });
        }

        String errorMessage = deleteLastSeparator(errorMessageBuilder.toString());

        var response = new ResultDto<String>();
        response.setFailureResponse(errorMessage, HttpStatus.SC_BAD_REQUEST);

        log.info(LogMessage.END_BAD_REQUEST, errorMessage);
        return ResponseEntity.status(HttpStatus.SC_BAD_REQUEST).body(response);
    }

    @ExceptionHandler(value = {Exception.class})
    public ResponseEntity<ResultDto<String>> handleGenericException(Exception e){
        log.info(LogMessage.START);
        log.info(LogMessage.EXCEPTION_CAPTURED, e.getMessage());

        var response = new ResultDto<String>();
        response.setFailureResponse(
                feelTheArtUtils.getMessageResponse(Constant.MESSAGE_RESPONSE_CODE_OPERATION_KO),
                HttpStatus.SC_INTERNAL_SERVER_ERROR);

        log.info(LogMessage.END_SERVER_ERROR, e.getMessage());
        return ResponseEntity.status(HttpStatus.SC_INTERNAL_SERVER_ERROR).body(response);
    }

    /**
     * This method allows the removal of the last occurrence of the separating character
     * @param string String from which to delete the last occurrence of the separator character
     * @return The string without separator's last occurence
     */
    private String deleteLastSeparator(String string) {
        return StringUtils.chop(string.stripTrailing());
    }
}
