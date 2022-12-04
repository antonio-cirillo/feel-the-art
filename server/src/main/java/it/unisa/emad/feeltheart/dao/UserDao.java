package it.unisa.emad.feeltheart.dao;

import it.unisa.emad.feeltheart.dto.user.UserDto;
import org.springframework.stereotype.Repository;

@Repository
public interface UserDao {

    String insertUser(UserDto request);
    UserDto getUserByDeviceId(String deviceId);

    Boolean updateUser(UserDto request);
}
