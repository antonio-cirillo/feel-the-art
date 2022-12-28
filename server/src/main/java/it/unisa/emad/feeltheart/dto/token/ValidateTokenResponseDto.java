package it.unisa.emad.feeltheart.dto.token;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serial;
import java.io.Serializable;

@Data
@EqualsAndHashCode(callSuper = true)
@JsonInclude(JsonInclude.Include.NON_ABSENT)
public class ValidateTokenResponseDto extends GeneralTokenResponseDto implements Serializable {

    @Serial
    private static final long serialVersionUID = -3978263052196072115L;

}
