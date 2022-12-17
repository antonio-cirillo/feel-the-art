package it.unisa.emad.feeltheart.dto.question;

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
public class AnswerDto implements Serializable {

    @Serial
    private static final long serialVersionUID = 4458990183610196411L;

    @Schema(description = "")
    private String identifier;

    @Schema(description = "")
    private String answer;
}
