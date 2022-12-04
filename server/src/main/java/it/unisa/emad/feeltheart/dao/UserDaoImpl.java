package it.unisa.emad.feeltheart.dao;

import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.WriteResult;
import com.google.firebase.cloud.FirestoreClient;
import it.unisa.emad.feeltheart.constant.LogMessage;
import it.unisa.emad.feeltheart.dto.user.UserDto;
import lombok.extern.log4j.Log4j2;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Repository;

@Log4j2
@Repository(value = "UserDaoImpl")
public class UserDaoImpl implements UserDao{

    private static final String USER_COLLECTION = "User";

    @Override
    public String insertUser(UserDto request) {
        log.info(LogMessage.START);

        String deviceId = request.getUser_info().getId_device();

        try{
            Firestore dbFirestore = FirestoreClient.getFirestore();
            dbFirestore
                    .collection(USER_COLLECTION)
                    .document(deviceId)
                    .create(request);

            log.info(LogMessage.END);
            return deviceId;
        }
        catch (Exception e){
            log.error(LogMessage.ERROR, e.getMessage());
            return null;
        }
    }

    @Override
    public UserDto getUserByDeviceId(String deviceId) {
        log.info(LogMessage.START);

        try{
            Firestore dbFirestore = FirestoreClient.getFirestore();

            DocumentReference documentReference = dbFirestore
                    .collection(USER_COLLECTION)
                    .document(deviceId);

            ApiFuture<DocumentSnapshot> future = documentReference.get();
            DocumentSnapshot document = future.get();

            if(document.exists()){
                log.info(LogMessage.DOCUMENT_FOUND);
                log.info(LogMessage.END);
                return document.toObject(UserDto.class);
            }else {
                log.info(LogMessage.DOCUMENT_NOT_FOUND);
                log.info(LogMessage.END);
                return null;
            }
        }
        catch (InterruptedException e){
            log.warn("Interrupted exception: {}", e.getMessage());
            Thread.currentThread().interrupt();
            return null;
        }
        catch (Exception e){
            log.error(LogMessage.ERROR, e.getMessage());
            return null;
        }
    }

    @Override
    public Boolean updateUser(UserDto request) {
        log.info(LogMessage.START);

        String deviceId = request.getUser_info().getId_device();

        try {
            Firestore dbFirestore = FirestoreClient.getFirestore();
            ApiFuture<WriteResult> writeResultApiFuture = dbFirestore
                    .collection(USER_COLLECTION)
                    .document(deviceId)
                    .set(request);

            if(StringUtils.isBlank(writeResultApiFuture.get().getUpdateTime().toString())){
                log.error(LogMessage.OPERATION_KO);
                return Boolean.FALSE;
            }

            log.info(LogMessage.END);
            return Boolean.TRUE;
        }
        catch (InterruptedException e){
            log.warn("Interrupted exception: {}", e.getMessage());
            Thread.currentThread().interrupt();
            return Boolean.FALSE;
        }
        catch (Exception e){
            log.error(LogMessage.ERROR, e.getMessage());
            return Boolean.FALSE;
        }
    }
}
