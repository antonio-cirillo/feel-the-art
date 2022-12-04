package it.unisa.emad.feeltheart.service;

import it.unisa.emad.feeltheart.constant.Constant;
import it.unisa.emad.feeltheart.constant.LogMessage;
import it.unisa.emad.feeltheart.dao.UserDao;
import it.unisa.emad.feeltheart.dto.token.GenerateTokenRequestDto;
import it.unisa.emad.feeltheart.dto.user.InitializeUserRequestDto;
import it.unisa.emad.feeltheart.dto.user.UserDto;
import it.unisa.emad.feeltheart.exception.CreateUserException;
import it.unisa.emad.feeltheart.util.token.TokenUtil;
import lombok.extern.log4j.Log4j2;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Log4j2
@Service(value = "UserServiceImpl")
public class UserServiceImpl implements UserService{

    private final TokenUtil tokenUtil;
    private final UserDao userDao;

    @Autowired
    public UserServiceImpl(TokenUtil tokenUtil, UserDao userDao) {
        this.tokenUtil = tokenUtil;
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
    public String initializeUser(InitializeUserRequestDto request) {
        log.info(LogMessage.START);

        String token = request.getToken();

        try{
            String deviceId = tokenUtil.getUserInfo(token).getUser_info().getId_device();

            var checkUser = getUserByDeviceId(deviceId);
            if(null == checkUser){
                log.info(LogMessage.USER_NOT_FOUND);
                createUser(deviceId);

            }else {
                log.info(LogMessage.USER_FOUND);
            }
        }catch (Exception e){
            log.error(LogMessage.ERROR, e.getMessage());
            return null;
        }

        log.info(LogMessage.END);
        return tokenUtil.generateToken(new GenerateTokenRequestDto());
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
