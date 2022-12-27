package it.unisa.emad.feeltheart.dto.avatar;

import com.fasterxml.jackson.annotation.JsonInclude;

import java.io.Serial;
import java.io.Serializable;

@JsonInclude(JsonInclude.Include.NON_ABSENT)
public class SaveGeneratedAvatarRequestDto implements Serializable {

    @Serial
    private static final long serialVersionUID = 7260524887560856448L;

}
