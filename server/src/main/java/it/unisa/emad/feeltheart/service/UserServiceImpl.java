package it.unisa.emad.feeltheart.service;

import com.google.gson.Gson;
import it.unisa.emad.feeltheart.constant.Constant;
import it.unisa.emad.feeltheart.constant.LogMessage;
import it.unisa.emad.feeltheart.dao.UserDao;
import it.unisa.emad.feeltheart.dto.user.*;
import it.unisa.emad.feeltheart.exception.CreateUserException;
import java.util.Collections;
import lombok.extern.log4j.Log4j2;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Log4j2
@Service(value = "UserServiceImpl")
public class UserServiceImpl implements UserService{

    private final UserDao userDao;

    @Autowired
    public UserServiceImpl(UserDao userDao) {
        this.userDao = userDao;
    }

    @Override
    public String insertUser(InsertUserRequestDto request) {
        log.info(LogMessage.START);

        String deviceId = request.getId_device();
        String authCode = request.getAuth_code();

        UserDto userToInsert = new UserDto();

        userToInsert.clearUser(deviceId, authCode);

        try {
            userDao.insertUser(userToInsert);

            log.info(LogMessage.END);
            return deviceId;
        }catch (Exception e){
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
    public InitializeUserResponseDto initializeUser(InitializeUserRequestDto request) {
        log.info(LogMessage.START);

        String authCode = request.getAuth_code();
        String deviceId = request.getId_device();

        if(StringUtils.isBlank(authCode) && StringUtils.isNotBlank(deviceId)){
            log.info(LogMessage.USER_FIRST_ACCESS);
            return userFirstAccess(deviceId);
        }else if(StringUtils.isNotBlank(authCode) && StringUtils.isNotBlank(deviceId)){
            log.info(LogMessage.USER_AUTHENTICATE);
            return userAuthenticate(deviceId, authCode);
        }else{
            log.info(LogMessage.ACCESS_KO);
            return null;
        }
    }

    @Override
    public Boolean updateUser(UserDto request) {
        log.info(LogMessage.START);

        String deviceId = request.getUser_info().getId_device();
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

            log.info("PRE-SORT: {}", new Gson().toJson(result));
            result.sort(new UserComparatorByStatistics());
            log.info("POST-SORT: {}", new Gson().toJson(result));

            log.info(LogMessage.END);
            return result;
        } catch (InterruptedException e){
            log.warn("Interrupted exception: {}", e.getMessage());
            Thread.currentThread().interrupt();
            return Collections.emptyList();
        }
        catch (Exception e){
            log.error(LogMessage.ERROR, e.getMessage());
            return Collections.emptyList();
        }
    }

    /**
     *
     * @param deviceId
     * @param authCode
     * @return
     */
    private InitializeUserResponseDto userAuthenticate(String deviceId, String authCode) {
        log.info(LogMessage.START);

        var result = new InitializeUserResponseDto();

        var userToRecover = getUserByDeviceId(deviceId);

        if(null == userToRecover
                || !userToRecover.getUser_info().getAuth_code().equals(authCode)){
            log.error(LogMessage.ACCESS_KO);
            return null;
        }

        result.setUser(userToRecover);

        log.info(LogMessage.END);
        return result;
    }

    /**
     *
     * @param deviceId
     * @return
     */
    private InitializeUserResponseDto userFirstAccess(String deviceId) {
        log.info(LogMessage.START);

        var result = new InitializeUserResponseDto();
        var userToInsert = new InsertUserRequestDto();

        String authCode = RandomStringUtils.random(Constant.AUTH_CODE_SIZE, true, true);

        userToInsert.setId_device(deviceId);
        userToInsert.setAuth_code(authCode);

        insertUser(userToInsert);

        result.setAuth_code(authCode);

        log.info(LogMessage.END);
        return result;
    }
}
