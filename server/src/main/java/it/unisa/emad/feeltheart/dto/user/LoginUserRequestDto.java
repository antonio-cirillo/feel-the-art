package it.unisa.emad.feeltheart.dto.user;

import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import java.io.Serial;
import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
@JsonInclude(JsonInclude.Include.NON_ABSENT)
public class LoginUserRequestDto implements Serializable {

    @Serial
    private static final long serialVersionUID = -6314329162922455790L;

    @NotBlank(message = "Il campo id_device non è valorizzato")
    @Schema(description = "User device identifier")
    private String id_device;

    @NotBlank(message = "Il campo random_identifier non è valorizzato")
    @Schema(description = "Authentication code")
    private String random_identifier;
}
