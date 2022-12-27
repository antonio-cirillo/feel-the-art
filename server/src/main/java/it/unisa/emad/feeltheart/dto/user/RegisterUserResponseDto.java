package it.unisa.emad.feeltheart.dto.user;

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
public class RegisterUserResponseDto implements Serializable {
    @Serial
    private static final long serialVersionUID = -8808034323517192084L;

    @Schema(description = "")
    private String token;

    @Schema(description = "")
    private String random_identifier;
}
