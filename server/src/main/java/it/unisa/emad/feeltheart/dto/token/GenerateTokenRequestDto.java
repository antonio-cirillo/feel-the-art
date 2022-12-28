package it.unisa.emad.feeltheart.dto.token;

import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serial;
import java.io.Serializable;
import java.util.Map;

@Data
@NoArgsConstructor
@AllArgsConstructor
@JsonInclude(JsonInclude.Include.NON_ABSENT)
public class GenerateTokenRequestDto implements Serializable {

    @Serial
    private static final long serialVersionUID = 4971185756281873500L;

    @Schema(description = "Token's claim")
    private Map<String, String> params;

}
