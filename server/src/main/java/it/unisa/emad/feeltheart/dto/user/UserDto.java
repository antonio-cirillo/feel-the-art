package it.unisa.emad.feeltheart.dto.user;

import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.v3.oas.annotations.media.Schema;
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
import java.util.Comparator;

@Data
@NoArgsConstructor
@AllArgsConstructor
@JsonInclude(JsonInclude.Include.NON_ABSENT)
public class UserDto implements Serializable {

    @Serial
    private static final long serialVersionUID = -8470779464279629436L;

    @Schema(description = "Oggetto contenente le info dell'utente")
    private UserInfoDto user_info;

    @Schema(description = "Oggetto contenente i progressi dell'utente")
    private ProgressionDto progression;

    @Schema(description = "Oggetto contenente i dettagli dell'avatar")
    private AvatarDto avatar;

    @Schema(description = "Oggetto contenente le statistiche dell'utente")
    private StatisticDto statistics;

    /**
     * This method initializes the data of a user
     * @param deviceId string containing the device identifier
     */
    public void clearUser(String deviceId, String authCode){
        this.setUser_info(getNewUserInfo(deviceId, authCode));
        this.setProgression(getNewProgression());
        this.setAvatar(getNewAvatar());
        this.setStatistics(getNewStatistics());
    }

    /**
     * This method creates an object containing the user's initial statistics
     * @return An object containing statistics
     */
    private StatisticDto getNewStatistics() {
        return new StatisticDto(
                0L,
                0L,
                0L,
                0L,
                0L
        );
    }

    /**
     * This method creates an object containing the user's initial avatar
     * @return An object containing avatar
     */
    private AvatarDto getNewAvatar() {
        return new AvatarDto(
                StringUtils.EMPTY,
                new ArrayList<>()
        );
    }

    /**
     * This method creates an object containing the user's initial progress
     * @return An object containing progression
     */
    private ProgressionDto getNewProgression() {
        return new ProgressionDto(
                1L,
                0.0,
                1.0);
    }

    /**
     * This method creates an object containing the user's info
     * @param deviceId string containing the device identifier
     * @return An object containing user's info
     */
    private UserInfoDto getNewUserInfo(String deviceId, String authCode) {
        return new UserInfoDto(
                deviceId,
                authCode);
    }

}
