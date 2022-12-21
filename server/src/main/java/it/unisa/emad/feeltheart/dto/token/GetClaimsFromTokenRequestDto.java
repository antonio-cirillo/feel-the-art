package it.unisa.emad.feeltheart.dto.token;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.io.Serial;
import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = true)
@JsonInclude(JsonInclude.Include.NON_ABSENT)
public class GetClaimsFromTokenRequestDto extends GeneralTokenRequestDto implements Serializable {

    @Serial
    private static final long serialVersionUID = -2054916428213048770L;

}
