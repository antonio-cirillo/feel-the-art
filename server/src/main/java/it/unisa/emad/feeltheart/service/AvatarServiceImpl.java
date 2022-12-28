package it.unisa.emad.feeltheart.service;

import it.unisa.emad.feeltheart.constant.Constant;
import it.unisa.emad.feeltheart.constant.LogMessage;
import it.unisa.emad.feeltheart.dto.avatar.*;
import it.unisa.emad.feeltheart.dto.user.UserDto;
import it.unisa.emad.feeltheart.exception.InsufficientPointException;
import it.unisa.emad.feeltheart.exception.UpdateUserException;
import it.unisa.emad.feeltheart.exception.UserNotFoundException;
import it.unisa.emad.feeltheart.util.FeelTheArtUtils;
import lombok.extern.log4j.Log4j2;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;

@Log4j2
@Service(value = "AvatarServiceImpl")
public class AvatarServiceImpl implements AvatarService{

    private final FeelTheArtUtils feelTheArtUtils;
    private final UserService userService;

    @Autowired
    public AvatarServiceImpl(FeelTheArtUtils feelTheArtUtils, UserService userService) {
        this.feelTheArtUtils = feelTheArtUtils;
        this.userService = userService;
    }

    @Override
    public SetAvatarResponseDto setAvatar(SetAvatarRequestDto request) {
        log.info(LogMessage.START);

        String deviceId = feelTheArtUtils.getDeviceId();
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
                return new SetAvatarResponseDto(Boolean.TRUE);
            }else{
                log.error(LogMessage.AVATAR_NOT_FOUND);
                log.info(LogMessage.END);
                return new SetAvatarResponseDto(Boolean.FALSE);
            }
        } catch (Exception e){
            log.error(LogMessage.ERROR, e.getMessage());
            return new SetAvatarResponseDto(Boolean.FALSE);
        }
    }

    @Override
    public SaveGeneratedAvatarResponseDto saveGeneratedAvatar(SaveGeneratedAvatarRequestDto request) {
        log.info(LogMessage.START);

        String deviceId = feelTheArtUtils.getDeviceId();

        try {
            UserDto user = getUserByDeviceId(deviceId);

            addAvatarToUser(user);

            log.info(LogMessage.END);
            return new SaveGeneratedAvatarResponseDto(Boolean.TRUE);
        }catch (Exception e){
            log.error(LogMessage.ERROR, e.getMessage());
            return new SaveGeneratedAvatarResponseDto(Boolean.FALSE);
        }
    }

    @Override
    public GeneratedAvatarResponseDto generateAvatar(GeneratedAvatarRequestDto request) {
        log.info(LogMessage.START);

        String deviceId = feelTheArtUtils.getDeviceId();
        var result = new GeneratedAvatarResponseDto();

        try {
            UserDto user = getUserByDeviceId(deviceId);
            String avatar = addGeneratedAvatarToUser(user);
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
     * This method allows an avatar to be added to the user's avatar
     * @param user User to add avatar to
     */
    private void addAvatarToUser(UserDto user){
        log.info(LogMessage.START);

        String lastGeneratedAvatar = user.getAvatar().getLast_generated();
        List<String> avatarList = user.getAvatar().getLibrary();

        if(null == avatarList || avatarList.isEmpty()){
            log.info("The user's library is null or empty");
            user.getAvatar().setLibrary(Collections.singletonList(lastGeneratedAvatar));
        }else{
            avatarList.add(0, lastGeneratedAvatar);
            user.getAvatar().setLibrary(avatarList);
        }

        if(Boolean.FALSE.equals(userService.updateUser(user))){
            log.error(LogMessage.OPERATION_KO);
            throw new UpdateUserException(Constant.UPDATE_USER_KO);
        }

        log.info(LogMessage.END);
    }

    /**
     * This method allows an avatar to be added to the user
     * @param user User to add avatar to
     */
    private String addGeneratedAvatarToUser(UserDto user){
        log.info(LogMessage.START);

        Double points = user.getProgression().getUnlock_counter();
        List<String> avatarList = user.getAvatar().getLibrary();
        String generatedAvatar = RandomStringUtils.random(Constant.AVATAR_CODE_SIZE, true, true);

        if(points < 1) {
            log.error("Insufficient points");
            throw new InsufficientPointException("Insufficient points");
        }

        while (avatarList.contains(generatedAvatar)) {
            generatedAvatar = RandomStringUtils.random(Constant.AVATAR_CODE_SIZE, true, true);
        }

        user.getProgression().setUnlock_counter(points - 1);
        user.getAvatar().setLast_generated(generatedAvatar);

        if(Boolean.FALSE.equals(userService.updateUser(user))){
            log.error(LogMessage.OPERATION_KO);
            throw new UpdateUserException(Constant.UPDATE_USER_KO);
        }

        log.info(LogMessage.END);
        return generatedAvatar;
    }

}
