package it.unisa.emad.feeltheart.service;

import it.unisa.emad.feeltheart.dto.user.InitializeUserRequestDto;
import it.unisa.emad.feeltheart.dto.user.UserDto;
import org.springframework.stereotype.Service;

@Service
public interface UserService {

    String insertUser(UserDto request);

    UserDto getUserByDeviceId(String deviceId);

    String initializeUser(InitializeUserRequestDto request);

    Boolean updateUser(UserDto request);
}
