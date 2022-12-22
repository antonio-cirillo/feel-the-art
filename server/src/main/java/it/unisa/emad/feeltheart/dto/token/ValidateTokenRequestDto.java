package it.unisa.emad.feeltheart.dto.token;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.*;

import java.io.Serial;
import java.io.Serializable;

@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = true)
@JsonInclude(JsonInclude.Include.NON_ABSENT)
public class ValidateTokenRequestDto extends GeneralTokenRequestDto implements Serializable {

    @Serial
    private static final long serialVersionUID = -782338242695490775L;

    @Builder
    public ValidateTokenRequestDto(String token){
        super(token);
    }

}
