package it.unisa.emad.feeltheart.dto.user;

import com.fasterxml.jackson.annotation.JsonInclude;
import it.unisa.emad.feeltheart.dto.avatar.AvatarDto;
import it.unisa.emad.feeltheart.dto.progression.ProgressionDto;
import it.unisa.emad.feeltheart.dto.statistic.StatisticDto;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.apache.commons.lang3.StringUtils;

import java.io.Serial;
import java.io.Serializable;
import java.util.ArrayList;

@Data
@NoArgsConstructor
@AllArgsConstructor
@JsonInclude(JsonInclude.Include.NON_ABSENT)
public class UserDto implements Serializable {

    @Serial
    private static final long serialVersionUID = -8470779464279629436L;

    private UserInfoDto user_info;

    private ProgressionDto progression;

    private AvatarDto avatar;

    private StatisticDto statistics;

    public void clearUser(String deviceId){
        this.setUser_info(getNewUserInfo(deviceId));
        this.setProgression(getNewProgression());
        this.setAvatar(getNewAvatar());
        this.setStatistics(getNewStatistics());
    }

    private StatisticDto getNewStatistics() {
        return new StatisticDto(
                0L,
                0L,
                0L,
                0L,
                0L
        );
    }

    private AvatarDto getNewAvatar() {
        return new AvatarDto(
                StringUtils.EMPTY,
                new ArrayList<>()
        );
    }

    private ProgressionDto getNewProgression() {
        return new ProgressionDto(
                1L,
                0.0,
                1.0);
    }

    private UserInfoDto getNewUserInfo(String deviceId) {
        return new UserInfoDto(deviceId);
    }

}
