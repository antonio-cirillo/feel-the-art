package it.unisa.emad.feeltheart.dto.progression;

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
public class ProgressionDto implements Serializable {

    @Serial
    private static final long serialVersionUID = -6759280777500805610L;

    @Schema(description = "User's level")
    private Long level;

    @Schema(description = "User's experience point")
    private Double exp;

    @Schema(description = "")
    private Double unlock_counter;
}
