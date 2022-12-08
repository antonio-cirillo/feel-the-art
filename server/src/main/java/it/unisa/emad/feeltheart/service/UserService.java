package it.unisa.emad.feeltheart.service;

import it.unisa.emad.feeltheart.dto.user.*;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface UserService {

    String insertUser(InsertUserRequestDto request);

    UserDto getUserByDeviceId(String deviceId);

    InitializeUserResponseDto initializeUser(InitializeUserRequestDto request);

    Boolean updateUser(UserDto request);

    List<UserDto> getLeaderboard(GetLeaderboardRequestDto request);
}
