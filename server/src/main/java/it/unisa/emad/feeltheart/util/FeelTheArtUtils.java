package it.unisa.emad.feeltheart.util;

import it.unisa.emad.feeltheart.constant.Constant;
import it.unisa.emad.feeltheart.constant.LogMessage;
import lombok.extern.log4j.Log4j2;
import org.apache.commons.lang3.StringUtils;
import org.json.JSONObject;
import org.json.JSONTokener;
import org.springframework.beans.factory.ObjectFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;

@Log4j2
@Component
public class FeelTheArtUtils {

    @Value(value = "${path.multilanguage}")
    private String pathMultilanguage;

    private final ObjectFactory<HttpSession> httpSessionFactory;

    @Autowired
    public FeelTheArtUtils(ObjectFactory<HttpSession> httpSessionFactory) {
        this.httpSessionFactory = httpSessionFactory;
    }

    /**
     * This method retrieves the chosen language from the session
     * @return Unique code representing the chosen language
     */
    public String getLanguage() {
        log.info(LogMessage.START);

        try{
            Object object = httpSessionFactory.getObject().getAttribute(Constant.KEY_LANGUAGE);

            if(null != object){
                log.info(LogMessage.CHOSEN_LANGUAGE, String.valueOf(object));
                log.info(LogMessage.END);

                return String.valueOf(object);
            }

            else{
                log.info(LogMessage.DEFAULT_LANGUAGE);
                log.info(LogMessage.END);

                return Constant.LANGUAGE_ITALIAN;
            }
        }catch (Exception e){
            log.info(LogMessage.ERROR, e.getMessage());
            log.info(LogMessage.DEFAULT_LANGUAGE);
            log.info(LogMessage.END);

            return Constant.LANGUAGE_ITALIAN;
        }
    }

    /**
     * This method retrieves the response message in the chosen language
     * @param messageCode unique message code
     * @return response message in chosen language
     */
    public String getMessageResponse(String messageCode) {
        log.info(LogMessage.START);

        try {
            String languageCode = getLanguage();

            var url = new URL(pathMultilanguage);
            BufferedReader read = new BufferedReader(
                    new InputStreamReader(url.openStream()));

            JSONTokener jsonTokener = new JSONTokener(read);
            JSONObject json = new JSONObject(jsonTokener);

            JSONObject messageObject = json.getJSONObject(messageCode);
            String message = messageObject.getString(languageCode);

            log.info(LogMessage.RESPONSE, message);

            log.info(LogMessage.END);
            return message;
        } catch(Exception e){
            log.error(LogMessage.ERROR, e.getMessage());
            return StringUtils.EMPTY;
        }
    }

    /**
     * This method retrieves the device identifier from the session
     * @return device identifier
     */
    public String getDeviceId() {
        log.info(LogMessage.START);

        try{
            Object object = httpSessionFactory.getObject().getAttribute(Constant.KEY_ID_DEVICE);

            if(null != object){
                log.info(LogMessage.ID_DEVICE, String.valueOf(object));
                return String.valueOf(object);
            }

            else{
                log.info(LogMessage.DEFAULT_ID_DEVICE);
                return Constant.DEFAULT_ID_DEVICE;
            }
        }catch (Exception e){
            log.info(LogMessage.ERROR, e.getMessage());
            return Constant.DEFAULT_ID_DEVICE;
        }
    }
}
