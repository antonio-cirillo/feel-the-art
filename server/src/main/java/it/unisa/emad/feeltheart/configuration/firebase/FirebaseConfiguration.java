package it.unisa.emad.feeltheart.configuration.firebase;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import it.unisa.emad.feeltheart.constant.LogMessage;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;
import org.springframework.util.ResourceUtils;

import javax.annotation.PostConstruct;
import java.io.FileInputStream;

@Log4j2
@Service
public class FirebaseConfiguration {

    @PostConstruct
    public void initialize() {
        try (FileInputStream serviceAccount = new FileInputStream(ResourceUtils.getFile("classpath:serviceaccount.json"))){
            FirebaseOptions options = new FirebaseOptions.Builder()
                    .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                    .setDatabaseUrl("https://chatapp-e6e15.firebaseio.com")
                    .build();

            FirebaseApp.initializeApp(options);
        } catch (Exception e) {
            log.info(LogMessage.ERROR, e.getMessage());
        }
    }
}
