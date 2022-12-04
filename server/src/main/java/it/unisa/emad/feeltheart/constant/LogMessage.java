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
    public static final String DEFAULT_LANGUAGE = "Default language";

    public static final String OFFSET_VALUE = "offset = {}";
    public static final String LIMIT_VALUE = "limit = {}";
    public static final String DOCUMENT_FOUND = "Document found";
    public static final String DOCUMENT_NOT_FOUND = "Document not found";
    public static final String USER_NOT_FOUND = "User doesn't exist";
    public static final String USER_FOUND = "User found";

    private LogMessage(){
    }
}
