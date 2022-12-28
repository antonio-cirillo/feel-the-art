package it.unisa.emad.feeltheart.dto.avatar;

import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serial;
import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
@JsonInclude(JsonInclude.Include.NON_ABSENT)
public class GeneratedAvatarResponseDto implements Serializable {

    @Serial
    private static final long serialVersionUID = -2373991982114165355L;

    @Schema(description = "String containing the encoding of the generated avatar")
    private String avatar_generated;
}
