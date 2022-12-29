package it.unisa.emad.feeltheart.dto.avatar;

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
public class SaveGeneratedAvatarResponseDto implements Serializable {

    @Serial
    private static final long serialVersionUID = -5361730703517733385L;

    @Schema(description = "Boolean indicating the outcome of the operation")
    private Boolean success;

}
