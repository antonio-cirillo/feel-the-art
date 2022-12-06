package it.unisa.emad.feeltheart.exception;

import java.io.Serial;

public class UpdateUserException extends RuntimeException{

    @Serial
    private static final long serialVersionUID = 1058433192665180462L;

    public UpdateUserException(String message){
        super(message);
    }
}
