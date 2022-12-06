package it.unisa.emad.feeltheart.service;

import it.unisa.emad.feeltheart.constant.Constant;
import it.unisa.emad.feeltheart.constant.LogMessage;
import it.unisa.emad.feeltheart.dto.avatar.AddAvatarRequestDto;
import it.unisa.emad.feeltheart.dto.avatar.GeneratedAvatarRequestDto;
import it.unisa.emad.feeltheart.dto.avatar.GeneratedAvatarResponseDto;
import it.unisa.emad.feeltheart.dto.avatar.SetAvatarRequestDto;
import it.unisa.emad.feeltheart.dto.user.UserDto;
import it.unisa.emad.feeltheart.exception.UpdateUserException;
import it.unisa.emad.feeltheart.exception.UserNotFoundException;
import lombok.extern.log4j.Log4j2;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

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

        String deviceId = request.getDeviceId();
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
    public Boolean addAvatar(AddAvatarRequestDto request) {
        log.info(LogMessage.START);

        String deviceId = request.getDeviceId();
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

        String deviceId = request.getDeviceId();
        var result = new GeneratedAvatarResponseDto();

        try {
            UserDto user = getUserByDeviceId(deviceId);
            String avatar = RandomStringUtils.random(10, true, true);

            addAvatarToUser(user, avatar, Boolean.TRUE);

            result.setAvatarGenerated(avatar);

            log.info(LogMessage.END);
            return result;
        }catch (Exception e){
            log.error(LogMessage.ERROR, e.getMessage());
            return null;
        }
    }

    /**
     *
     * @param deviceId
     * @return
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
     *
     * @param user
     * @param avatar
     * @param generateAvatar
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
        else{
            if(Boolean.TRUE.equals(generateAvatar)){
                avatar = RandomStringUtils.random(10, true, true);
                addAvatarToUser(user, avatar, Boolean.TRUE);
            }
        }

        if(Boolean.FALSE.equals(userService.updateUser(user))){
            log.error(LogMessage.OPERATION_KO);
            throw new UpdateUserException(Constant.UPDATE_USER_KO);
        }

        log.info(LogMessage.END);
    }

}
