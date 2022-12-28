package it.unisa.emad.feeltheart.exception;

import java.io.Serial;

public class InsufficientPointException extends RuntimeException{

    @Serial
    private static final long serialVersionUID = -3709908439662732257L;

    public InsufficientPointException(String message){
        super(message);
    }
}
