package it.unisa.emad.feeltheart.dto.token;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serial;
import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
@JsonInclude(JsonInclude.Include.NON_ABSENT)
public class GenerateTokenResponseDto implements Serializable {

    @Serial
    private static final long serialVersionUID = 6409541012206027307L;

    private Oauth2Dto token;

    private Boolean success;

    private String description;

    public void error(String description) {
        this.setDescription(description);
        this.setSuccess(false);
        this.setToken(null);
    }
}
