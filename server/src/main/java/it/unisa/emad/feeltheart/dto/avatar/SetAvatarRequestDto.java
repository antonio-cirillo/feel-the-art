package it.unisa.emad.feeltheart.dto.avatar;

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
public class SetAvatarRequestDto implements Serializable {

    @Serial
    private static final long serialVersionUID = -6491963162062884127L;

    private String deviceId;

    private String avatar;
}
