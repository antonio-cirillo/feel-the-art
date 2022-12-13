package it.unisa.emad.feeltheart.exception;

import java.io.Serial;

public class CreateUserException extends RuntimeException {

    @Serial
    private static final long serialVersionUID = -1224104220749102101L;

    public CreateUserException(String message){
        super(message);
    }
}
