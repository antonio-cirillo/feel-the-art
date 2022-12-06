package it.unisa.emad.feeltheart.service;

import it.unisa.emad.feeltheart.constant.Constant;
import it.unisa.emad.feeltheart.constant.LogMessage;
import it.unisa.emad.feeltheart.dao.UserDao;
import it.unisa.emad.feeltheart.dto.user.InitializeUserRequestDto;
import it.unisa.emad.feeltheart.dto.user.InitializeUserResponseDto;
import it.unisa.emad.feeltheart.dto.user.UserDto;
import it.unisa.emad.feeltheart.exception.CreateUserException;
import lombok.extern.log4j.Log4j2;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Log4j2
@Service(value = "UserServiceImpl")
public class UserServiceImpl implements UserService{

    private final UserDao userDao;

    @Autowired
    public UserServiceImpl(UserDao userDao) {
        this.userDao = userDao;
    }

    @Override
    public String insertUser(UserDto request) {
        return userDao.insertUser(request);
    }

    @Override
    public UserDto getUserByDeviceId(String deviceId) {
        return userDao.getUserByDeviceId(deviceId);
    }

    @Override
    public InitializeUserResponseDto initializeUser(InitializeUserRequestDto request) {
        log.info(LogMessage.START);

        String password = request.getPassword();
        String deviceId = request.getDeviceId();

        var result = new InitializeUserResponseDto();

        try{
            if(StringUtils.isBlank(password) && StringUtils.isNotBlank(deviceId)){
                log.info(LogMessage.USER_FIRST_ACCESS);
                return userFirstAccess(deviceId);
            }
            else if(StringUtils.isNotBlank(password) && StringUtils.isNotBlank(deviceId)){
                log.info(LogMessage.USER_AUTHENTICATE);
                return userAuthenticate(password, deviceId);
            }
            else{
                //TODO
            }

            log.info(LogMessage.END);
            return result;
        }catch (Exception e){
            log.error(LogMessage.ERROR, e.getMessage());
            return null;
        }
    }

    private InitializeUserResponseDto userAuthenticate(String password, String deviceId) {
        //TODO
        return null;
    }

    private InitializeUserResponseDto userFirstAccess(String deviceId) {
        //TODO
        return null;
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

        log.info(LogMessage.END);
        return userDao.updateUser(request);
    }

    private void createUser(String deviceId) throws Exception {
        log.info(LogMessage.START);

        var userToInsert = new UserDto();
        userToInsert.clearUser(deviceId);

        String checkDeviceId = insertUser(userToInsert);
        if(StringUtils.isBlank(checkDeviceId)){
            log.info(LogMessage.OPERATION_KO);
            throw new CreateUserException(Constant.CREATE_USER_KO);
        }

        log.info(LogMessage.END);
    }
}
