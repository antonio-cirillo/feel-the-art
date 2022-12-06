package it.unisa.emad.feeltheart.service;

import it.unisa.emad.feeltheart.dto.user.InitializeUserRequestDto;
import it.unisa.emad.feeltheart.dto.user.InitializeUserResponseDto;
import it.unisa.emad.feeltheart.dto.user.InsertUserRequestDto;
import it.unisa.emad.feeltheart.dto.user.UserDto;
import org.springframework.stereotype.Service;

@Service
public interface UserService {

    String insertUser(InsertUserRequestDto request);

    UserDto getUserByDeviceId(String deviceId);

    InitializeUserResponseDto initializeUser(InitializeUserRequestDto request);

    Boolean updateUser(UserDto request);
}
