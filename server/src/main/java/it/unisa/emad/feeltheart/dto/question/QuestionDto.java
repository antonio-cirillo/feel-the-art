package it.unisa.emad.feeltheart.dto.question;

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
public class QuestionDto implements Serializable {

    @Serial
    private static final long serialVersionUID = 504184795674239L;

    @Schema(description = "")
    private Long id;

    @Schema(description = "")
    private String image_url;

    @Schema(description = "")
    private String type;

    @Schema(description = "")
    private Long time_second;

    @Schema(description = "")
    private String question;

    @Schema(description = "")
    private String correct_answer;

    @Schema(description = "")
    private List<AnswerDto> answers;

}
