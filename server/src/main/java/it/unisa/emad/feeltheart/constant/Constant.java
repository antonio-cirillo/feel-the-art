package it.unisa.emad.feeltheart.constant;

public class Constant {

    //Header
    public static final String KEY_LANGUAGE = "message-language";

    //Languages
    public static final String LANGUAGE_ITALIAN = "IT";
    public static final String LANGUAGE_ENGLISH = "EN";

    //Keys for paged search
    public static final String UTILITY_KEY_OFFSET = "offset";
    public static final String UTILITY_KEY_LIMIT = "limit";

    //Code for message response
    public static final String MESSAGE_RESPONSE_CODE_OPERATION_OK = "0001";
    public static final String MESSAGE_RESPONSE_CODE_OPERATION_KO = "0002";
    public static final String MESSAGE_RESPONSE_CODE_BAD_REQUEST = "0003";
    public static final String MESSAGE_RESPONSE_CODE_FIELDS_NOT_VALID = "0004";
    public static final String MESSAGE_RESPONSE_FOUND_KO= "0005";

    public static final String SEPARATOR = ", ";
    public static final String CREATE_USER_KO = "Error during user creation";
    public static final String UPDATE_USER_KO = "Error during user update";
    public static final String USER_NOT_FOUND = "User not found";
    public static final int AUTH_CODE_SIZE = 20;
    public static final int AVATAR_CODE_SIZE = 10;
    public static final String AVATAR_ALREADY_EXISTS = "Avatar already in the collection";

    private Constant(){

    }

}
