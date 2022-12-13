package it.unisa.emad.feeltheart.dto.statistic;

import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serial;
import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
@JsonInclude(JsonInclude.Include.NON_ABSENT)
public class StatisticDto implements Serializable {

    @Serial
    private static final long serialVersionUID = 8660255178279795428L;

    @Schema(description = "Counter for the total number of games played")
    private Long total;

    @Schema(description = "Counter for the total number of games won")
    private Long first_place;

    @Schema(description = "Counter for the total number of seconds placed")
    private Long second_place;

    @Schema(description = "Counter for the total number of third places")
    private Long third_place;

    @Schema(description = "Counter for the total number of games lost")
    private Long lose;

}