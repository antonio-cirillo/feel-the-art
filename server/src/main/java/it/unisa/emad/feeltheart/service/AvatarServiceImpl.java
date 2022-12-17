package it.unisa.emad.feeltheart.service;

import it.unisa.emad.feeltheart.constant.Constant;
import it.unisa.emad.feeltheart.constant.LogMessage;
import it.unisa.emad.feeltheart.dto.avatar.SaveGeneratedAvatarRequestDto;
import it.unisa.emad.feeltheart.dto.avatar.GeneratedAvatarRequestDto;
import it.unisa.emad.feeltheart.dto.avatar.GeneratedAvatarResponseDto;
import it.unisa.emad.feeltheart.dto.avatar.SetAvatarRequestDto;
import it.unisa.emad.feeltheart.dto.user.UserDto;
import it.unisa.emad.feeltheart.exception.AvatarExistException;
import it.unisa.emad.feeltheart.exception.UpdateUserException;
import it.unisa.emad.feeltheart.exception.UserNotFoundException;
import lombok.extern.log4j.Log4j2;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;

@Log4j2
@Service(value = "AvatarServiceImpl")
public class AvatarServiceImpl implements AvatarService{

    private final UserService userService;

    @Autowired
    public AvatarServiceImpl(UserService userService) {
        this.userService = userService;
    }

    @Override
    public Boolean setAvatar(SetAvatarRequestDto request) {
        log.info(LogMessage.START);

        String deviceId = request.getId_device();
        String avatar = request.getAvatar();

        try {
            UserDto user = getUserByDeviceId(deviceId);

            List<String> avatarList = user.getAvatar().getLibrary();
            if(null != avatarList && avatarList.contains(avatar)){
                log.info(LogMessage.AVATAR_FOUND);

                avatarList.add(0, avatar);
                user.getAvatar().setLibrary(avatarList.stream().distinct().toList());

                userService.updateUser(user);

                log.info(LogMessage.END);
                return Boolean.TRUE;
            }else{
                log.error(LogMessage.AVATAR_NOT_FOUND);
                log.info(LogMessage.END);
                return Boolean.FALSE;
            }
        } catch (Exception e){
            log.error(LogMessage.ERROR, e.getMessage());
            return Boolean.FALSE;
        }
    }

    @Override
    public Boolean saveGeneratedAvatar(SaveGeneratedAvatarRequestDto request) {
        log.info(LogMessage.START);

        String deviceId = request.getId_device();
        String lastGeneratedAvatar = request.getLast_generated();

        try {
            UserDto user = getUserByDeviceId(deviceId);

            addAvatarToUser(user, lastGeneratedAvatar, Boolean.FALSE);

            log.info(LogMessage.END);
            return Boolean.TRUE;
        }catch (Exception e){
            log.error(LogMessage.ERROR, e.getMessage());
            return Boolean.FALSE;
        }
    }

    @Override
    public GeneratedAvatarResponseDto generateAvatar(GeneratedAvatarRequestDto request) {
        log.info(LogMessage.START);

        String deviceId = request.getId_device();
        var result = new GeneratedAvatarResponseDto();

        try {
            UserDto user = getUserByDeviceId(deviceId);
            String avatar = RandomStringUtils.random(Constant.AVATAR_CODE_SIZE, true, true);

            addAvatarToUser(user, avatar, Boolean.TRUE);

            result.setAvatar_generated(avatar);

            log.info(LogMessage.END);
            return result;
        }catch (Exception e){
            log.error(LogMessage.ERROR, e.getMessage());
            return null;
        }
    }

    /**
     * This method allows the retrieval of a user by device identifier
     * @param deviceId device identifier
     * @return user
     */
    private UserDto getUserByDeviceId(String deviceId){
        log.info(LogMessage.START);

        UserDto user = userService.getUserByDeviceId(deviceId);

        if(null == user){
            log.error(LogMessage.USER_NOT_FOUND);
            throw new UserNotFoundException(Constant.USER_NOT_FOUND);
        }

        log.info(LogMessage.END);
        return user;
    }

    /**
     * This method allows an avatar to be added to the user
     * @param user User to add avatar to
     * @param avatar String containing the avatar to be added
     * @param generateAvatar Flag indicating whether the avatar has been generated
     */
    private void addAvatarToUser(UserDto user, String avatar, Boolean generateAvatar){
        log.info(LogMessage.START);

        List<String> avatarList = user.getAvatar().getLibrary();

        if(null == avatarList){
            log.info("The user's library is null");
            user.getAvatar().setLibrary(Collections.singletonList(avatar));
        }
        else if(!avatarList.contains(avatar)){
            log.info("The user's library doesn't contain the avatar");
            avatarList.add(0, avatar);
            user.getAvatar().setLibrary(avatarList);
        }
        else if(Boolean.TRUE.equals(generateAvatar)){
            avatar = RandomStringUtils.random(Constant.AVATAR_CODE_SIZE, true, true);
            addAvatarToUser(user, avatar, Boolean.TRUE);
        }
        else {
            log.error(LogMessage.OPERATION_KO);
            throw new AvatarExistException(Constant.AVATAR_ALREADY_EXISTS);
        }

        if(Boolean.FALSE.equals(userService.updateUser(user))){
            log.error(LogMessage.OPERATION_KO);
            throw new UpdateUserException(Constant.UPDATE_USER_KO);
        }

        log.info(LogMessage.END);
    }

}
