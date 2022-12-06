package it.unisa.emad.feeltheart.dao;

import it.unisa.emad.feeltheart.dto.user.UserDto;
import org.springframework.stereotype.Repository;

import java.util.concurrent.ExecutionException;

@Repository
public interface UserDao {

    void insertUser(UserDto request);
    UserDto getUserByDeviceId(String deviceId) throws ExecutionException, InterruptedException;

    void updateUser(UserDto request);
}
