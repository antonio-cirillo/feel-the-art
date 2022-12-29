package it.unisa.emad.feeltheart.exception;

import java.io.Serial;

public class TokenException extends RuntimeException{
    @Serial
    private static final long serialVersionUID = 8650188690605732584L;

    public TokenException(String message){
        super(message);
    }
}
