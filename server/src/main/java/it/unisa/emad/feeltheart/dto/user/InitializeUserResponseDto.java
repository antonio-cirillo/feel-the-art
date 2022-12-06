package it.unisa.emad.feeltheart.dto.user;

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
public class InitializeUserResponseDto implements Serializable {

    @Serial
    private static final long serialVersionUID = -5876548086379160702L;

    private String auth_code;

    private UserDto user;
}
