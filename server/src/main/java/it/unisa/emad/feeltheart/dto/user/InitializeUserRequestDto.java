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
public class InitializeUserRequestDto implements Serializable {
    @Serial
    private static final long serialVersionUID = 1655258000101904128L;

    private String token;
}
