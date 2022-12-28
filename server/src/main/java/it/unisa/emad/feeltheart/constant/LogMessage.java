package it.unisa.emad.feeltheart.constant;

public class LogMessage {

    public static final String START = "*** START ***";
    public static final String END = "*** END ***";

    public static final String REQUEST = "Request: {}";
    public static final String RESPONSE = "Response: {}";

    public static final String END_BAD_REQUEST = "*** END WITH BAD REQUEST: {} ***";
    public static final String END_SERVER_ERROR = "*** END WITH SERVER ERROR: {} ***";

    public static final String ERROR = "Error: {}.";
    public static final String EXCEPTION_CAPTURED = "Captured exception: {}";

    public static final String OPERATION_OK = "Operation successful";
    public static final String OPERATION_KO = "Operation failed";

    public static final String CHOSEN_LANGUAGE = "Chosen language: {}";
    public static final String ID_DEVICE = "Device id: {}";
    public static final String DEFAULT_LANGUAGE = "Default language";
    public static final String DEFAULT_ID_DEVICE = "Default device id";

    public static final String DOCUMENT_FOUND = "Document found";
    public static final String DOCUMENT_NOT_FOUND = "Document not found";
    public static final String USER_NOT_FOUND = "User doesn't exist";
    public static final String USER_FOUND = "User found";
    public static final String USER_FIRST_ACCESS = "User's first access";
    public static final String USER_AUTHENTICATE = "User authentication";
    public static final String AVATAR_FOUND = "Avatar found";
    public static final String AVATAR_NOT_FOUND = "Avatar not found";
    public static final String ACCESS_KO = "Invalid login case";

    public static final String INTERRUPTED_EXCEPTION = "Interrupted exception: {}";
    public static final String QUESTION_NOT_FOUND = "Question doesn't exist";
    public static final String CARD_NOT_FOUND = "Cards don't exist";

    private LogMessage(){
    }
}
