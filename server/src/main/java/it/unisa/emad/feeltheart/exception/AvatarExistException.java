package it.unisa.emad.feeltheart.exception;

import java.io.Serial;

public class AvatarExistException extends RuntimeException{

    @Serial
    private static final long serialVersionUID = -1224112220749102101L;

    public AvatarExistException(String message){
        super(message);
    }
}
