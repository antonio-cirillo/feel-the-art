package it.unisa.emad.feeltheart.service;

import it.unisa.emad.feeltheart.constant.Constant;
import it.unisa.emad.feeltheart.constant.LogMessage;
import it.unisa.emad.feeltheart.dao.UserDao;
import it.unisa.emad.feeltheart.dto.token.GenerateTokenRequestDto;
import it.unisa.emad.feeltheart.dto.user.*;
import it.unisa.emad.feeltheart.exception.TokenException;
import it.unisa.emad.feeltheart.util.FeelTheArtUtils;
import it.unisa.emad.feeltheart.util.TokenUtils;
import lombok.extern.log4j.Log4j2;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;
import java.util.Map;

@Log4j2
@Service(value = "UserServiceImpl")
public class UserServiceImpl implements UserService{

    private final FeelTheArtUtils feelTheArtUtils;
    private final TokenUtils tokenUtils;
    private final UserDao userDao;

    @Autowired
    public UserServiceImpl(FeelTheArtUtils feelTheArtUtils, TokenUtils tokenUtils, UserDao userDao) {
        this.feelTheArtUtils = feelTheArtUtils;
        this.tokenUtils = tokenUtils;
        this.userDao = userDao;
    }

    @Override
    public String insertUser(InsertUserRequestDto request) {
        log.info(LogMessage.START);

        String deviceId = request.getId_device();
        String authCode = request.getRandom_identifier();

        UserDto userToInsert = new UserDto();

        userToInsert.clearUser(deviceId, authCode);

        try {
            userDao.insertUser(userToInsert);

            log.info(LogMessage.END);
            return deviceId;
        }catch (InterruptedException e){
            log.warn(LogMessage.INTERRUPTED_EXCEPTION, e.getMessage());
            Thread.currentThread().interrupt();
            return null;
        }
        catch (Exception e){
            log.error(LogMessage.ERROR, e.getMessage());
            return null;
        }
    }

    @Override
    public UserDto getUserByDeviceId(String deviceId) {
        log.info(LogMessage.START);

        try {
            UserDto userToRecover = userDao.getUserByDeviceId(deviceId);

            log.info(LogMessage.END);
            return userToRecover;
        }
        catch (InterruptedException e){
            log.warn(LogMessage.INTERRUPTED_EXCEPTION, e.getMessage());
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

        String deviceId = feelTheArtUtils.getDeviceId();
        UserDto userToRecover = getUserByDeviceId(deviceId);

        if(null == userToRecover){
            log.info(LogMessage.USER_NOT_FOUND);
            return Boolean.FALSE;
        }

        userDao.updateUser(request);

        log.info(LogMessage.END);
        return Boolean.TRUE;
    }

    @Override
    public List<UserDto> getLeaderboard(GetLeaderboardRequestDto request) {
        log.info(LogMessage.START);

        try {
            List<UserDto> result = userDao.getLeaderboard(request);

            result.sort(new UserComparatorByStatistics());

            log.info(LogMessage.END);
            return result;
        } catch (InterruptedException e){
            log.warn(LogMessage.INTERRUPTED_EXCEPTION, e.getMessage());
            Thread.currentThread().interrupt();
            return Collections.emptyList();
        }
        catch (Exception e){
            log.error(LogMessage.ERROR, e.getMessage());
            return Collections.emptyList();
        }
    }

    @Override
    public RegisterUserResponseDto registerUser(RegisterUserRequestDto request) {
        log.info(LogMessage.START);

        var result = new RegisterUserResponseDto();
        var userToInsert = new InsertUserRequestDto();

        String randomIdentifier = RandomStringUtils.random(Constant.AUTH_CODE_SIZE, true, true);
        String deviceId = request.getId_device();

        userToInsert.setId_device(deviceId);
        userToInsert.setRandom_identifier(randomIdentifier);

        insertUser(userToInsert);

        result.setRandom_identifier(randomIdentifier);
        result.setToken(getToken(deviceId));

        log.info(LogMessage.END);
        return result;
    }

    @Override
    public LoginUserResponseDto loginUser(LoginUserRequestDto request) {
        log.info(LogMessage.START);

        var result = new LoginUserResponseDto();

        String deviceId = request.getId_device();
        String randomIdentifier = request.getRandom_identifier();

        var userToRecover = getUserByDeviceId(deviceId);

        if(null == userToRecover
                || !userToRecover.getUser_info().getRandom_identifier().equals(randomIdentifier)){
            log.error(LogMessage.ACCESS_KO);
            return null;
        }

        result.setToken(getToken(deviceId));

        log.info(LogMessage.END);
        return result;
    }

    /**
     * This method allows you to generate the token
     * @param deviceId device identifier
     * @return token
     */
    private String getToken(String deviceId){
        log.info(LogMessage.START);

        var token =
                tokenUtils.generateToken(new GenerateTokenRequestDto(Map.of(Constant.KEY_ID_DEVICE, deviceId)));

        if(Boolean.FALSE.equals(token.getSuccess())){
            log.error(LogMessage.ERROR, token.getDescription());
            throw new TokenException(token.getDescription());
        }

        log.info(LogMessage.END);
        return token.getToken().getAccess_token();
    }
}
