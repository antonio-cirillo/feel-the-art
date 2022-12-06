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
public class AddAvatarRequestDto implements Serializable {

    @Serial
    private static final long serialVersionUID = 7260524887560856448L;

    private String deviceId;

    private String last_generated;

}
