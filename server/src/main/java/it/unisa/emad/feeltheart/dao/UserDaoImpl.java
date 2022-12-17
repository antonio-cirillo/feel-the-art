package it.unisa.emad.feeltheart.dao;

import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.*;
import com.google.firebase.cloud.FirestoreClient;
import com.google.gson.Gson;
import it.unisa.emad.feeltheart.constant.LogMessage;
import it.unisa.emad.feeltheart.dto.user.GetLeaderboardRequestDto;
import it.unisa.emad.feeltheart.dto.user.UserDto;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutionException;

@Log4j2
@Repository(value = "UserDaoImpl")
public class UserDaoImpl implements UserDao{

    private static final String USER_COLLECTION = "User";

    @Override
    public void insertUser(UserDto request) throws ExecutionException, InterruptedException {
        log.info(LogMessage.START);

        String deviceId = request.getUser_info().getId_device();

        Firestore dbFirestore = FirestoreClient.getFirestore();
        dbFirestore
                .collection(USER_COLLECTION)
                .document(deviceId)
                .create(request)
                .get();

        log.info(LogMessage.END);
    }

    @Override
    public UserDto getUserByDeviceId(String deviceId) throws ExecutionException, InterruptedException {
        log.info(LogMessage.START);

        Firestore dbFirestore = FirestoreClient.getFirestore();

        DocumentSnapshot document = dbFirestore
                .collection(USER_COLLECTION)
                .document(deviceId)
                .get()
                .get();

        log.info(LogMessage.END);
        return document.toObject(UserDto.class);
    }

    @Override
    public void updateUser(UserDto request) {
        log.info(LogMessage.START);

        String deviceId = request.getUser_info().getId_device();

        Firestore dbFirestore = FirestoreClient.getFirestore();

        dbFirestore
                .collection(USER_COLLECTION)
                .document(deviceId)
                .set(request);

        log.info(LogMessage.END);
    }

    @Override
    public List<UserDto> getLeaderboard(GetLeaderboardRequestDto request) throws ExecutionException, InterruptedException {
        log.info(LogMessage.START);

        Firestore dbFirestore = FirestoreClient.getFirestore();
        List<UserDto> result = new ArrayList<>();

        QuerySnapshot documentSnapshots = dbFirestore
                .collection(USER_COLLECTION)
                .limit(25)
                .get()
                .get();

        documentSnapshots.forEach(document -> {
            result.add(document.toObject(UserDto.class));
        });

        log.info(LogMessage.END);
        return result;
    }
}
