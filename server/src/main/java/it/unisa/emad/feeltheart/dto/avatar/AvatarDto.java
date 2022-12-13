package it.unisa.emad.feeltheart.dto.avatar;

import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serial;
import java.io.Serializable;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@JsonInclude(JsonInclude.Include.NON_ABSENT)
public class AvatarDto implements Serializable {

    @Serial
    private static final long serialVersionUID = 5944484763132127078L;

    @Schema(description = "String containing the representation of the last generated avatar")
    private String last_generated;

    @Schema(description = "List containing representations of avatars owned by the user")
    private List<String> library;
}
