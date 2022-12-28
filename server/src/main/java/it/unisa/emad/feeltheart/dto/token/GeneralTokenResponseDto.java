package it.unisa.emad.feeltheart.dto.token;

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
public class GeneralTokenResponseDto implements Serializable {

    @Serial
    private static final long serialVersionUID = -4231903427939524929L;

    @Schema(description = "Booleano che indica l'esito dell'operazione")
    private Boolean success;

    @Schema(description = "Stringa contenente una breve descrizione sull'esito dell'operazione")
    private String description;

    public void error(String description) {
        this.setDescription(description);
        this.setSuccess(Boolean.FALSE);
    }

    public void success(String description){
        this.setDescription(description);
        this.setSuccess(Boolean.TRUE);
    }
}
