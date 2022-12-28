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
public class GetQuestionByTypeRequestDto implements Serializable {

    @Serial
    private static final long serialVersionUID = -6670785866190270547L;

    @Schema(description = "Type whose questions you want to recover")
    private String type;
}
