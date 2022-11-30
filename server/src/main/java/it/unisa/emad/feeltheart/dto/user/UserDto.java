package it.unisa.emad.feeltheart.dto.user;

import com.fasterxml.jackson.annotation.JsonInclude;
import it.unisa.emad.feeltheart.dto.avatar.AvatarDto;
import it.unisa.emad.feeltheart.dto.progression.ProgressionDto;
import it.unisa.emad.feeltheart.dto.statistic.StatisticDto;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serial;
import java.io.Serializable;

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

}
