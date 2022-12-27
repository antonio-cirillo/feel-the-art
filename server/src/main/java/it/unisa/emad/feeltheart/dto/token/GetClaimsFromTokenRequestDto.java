package it.unisa.emad.feeltheart.dto.token;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.*;

import java.io.Serial;
import java.io.Serializable;

@Data
@NoArgsConstructor
@EqualsAndHashCode(callSuper = true)
@JsonInclude(JsonInclude.Include.NON_ABSENT)
public class GetClaimsFromTokenRequestDto extends GeneralTokenRequestDto implements Serializable {

    @Serial
    private static final long serialVersionUID = -2054916428213048770L;

    @Builder
    public GetClaimsFromTokenRequestDto(String token){
        super(token);
    }

}
