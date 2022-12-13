package it.unisa.emad.feeltheart.exception;

import java.io.Serial;

public class UserNotFoundException extends RuntimeException{

    @Serial
    private static final long serialVersionUID = -7293921628908151231L;

    public UserNotFoundException(String message){
        super(message);
    }
}
