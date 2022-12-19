package it.unisa.emad.feeltheart.dto.avatar;

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
public class SaveGeneratedAvatarRequestDto implements Serializable {

    @Serial
    private static final long serialVersionUID = 7260524887560856448L;

    @NotBlank(message = "Il campo id_device non è valorizzato")
    @Schema(description = "User device identifier")
    private String id_device;

}
