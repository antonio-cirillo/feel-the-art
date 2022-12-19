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
public class Oauth2Dto implements Serializable {

    @Serial
    private static final long serialVersionUID = -5366389508261919570L;

    private String access_token;

    private String token_type;

    private String expires_at;

}
