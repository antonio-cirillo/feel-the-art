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
public class Oauth2Dto implements Serializable {

    @Serial
    private static final long serialVersionUID = -5366389508261919570L;

    @Schema(description = "JWT token")
    private String access_token;

    @Schema(description = "Type of token")
    private String token_type;

    @Schema(description = "Expiration of the token")
    private String expires_at;

}
