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
public class SetAvatarRequestDto implements Serializable {

    @Serial
    private static final long serialVersionUID = -6491963162062884127L;

    @NotBlank(message = "Il campo avatar non è valorizzato")
    @Schema(description = "Stringa contenente l'avatar da inserire nella collezione")
    private String avatar;
}
