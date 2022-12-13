package it.unisa.emad.feeltheart.dto.common;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import lombok.Data;
import org.apache.http.HttpStatus;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDateTime;

@Data
@JsonInclude(Include.NON_ABSENT)
public class ResultDto<T> implements Serializable {

    @Serial
    private static final long serialVersionUID = 8903038957866003289L;

    protected boolean success;

    protected int code;

    protected String descrizione;

    protected T data;

    private LocalDateTime dateTime;

    /**
     * Costructor
     */
    public ResultDto(){
        clear();
    }

    /**
     * This method resets the object's fields
     */
    public void clear(){
        this.success = false;
        this.code = 0;
        this.data = null;
        this.descrizione = null;
        this.dateTime = LocalDateTime.now();
    }

    /**
     * This method returns the result of the operation
     * @return true in case the operation is successful, false otherwise
     */
    public boolean isSuccess() {
        return success;
    }

    /**
     * This method values the fields of the object in the case where the operation is successful
     * but what was desired was not obtained.
     * For example, when you want to retrieve data, but they aren't found.
     * @param message string containing the message to be displayed.
     */
    public void setSuccessFalseResponse(String message){
        this.descrizione = message;
        this.dateTime = LocalDateTime.now();
        this.success = Boolean.FALSE;
        this.code = HttpStatus.SC_OK;
    }

    /**
     * This method values the fields of the object in the case where the operation is successful.
     * @param message string containing the message to be displayed.
     */
    public void setSuccessTrueResponse(String message){
        this.descrizione = message;
        this.dateTime = LocalDateTime.now();
        this.success = Boolean.TRUE;
        this.code = HttpStatus.SC_OK;
    }

    /**
     * This method values the fields of the object in case the operation fails.
     * @param message string containing the message to be displayed.
     * @param code integer containing the HTTP code
     */
    public void setFailureResponse(String message, int code){
        this.descrizione = message;
        this.dateTime = LocalDateTime.now();
        this.success = Boolean.FALSE;
        this.code = code;
        this.data = null;
    }

}