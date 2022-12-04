package it.unisa.emad.feeltheart.util.token;

import it.unisa.emad.feeltheart.dto.token.GenerateTokenRequestDto;
import it.unisa.emad.feeltheart.dto.user.UserDto;
import lombok.extern.log4j.Log4j2;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.stereotype.Component;

@Log4j2
@Component
public class TokenUtil {

    public String generateToken(GenerateTokenRequestDto generateTokenRequest){
        return RandomStringUtils.random(20, true, true);
    }

    public UserDto getUserInfo(String token) {
        UserDto userDto = new UserDto();
        userDto.clearUser(token);
        return userDto;
    }
}
