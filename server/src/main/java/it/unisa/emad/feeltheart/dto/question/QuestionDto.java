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

    @Schema(description = "Question identifier")
    private String id;

    @Schema(description = "URL of a possible image associated with the question")
    private String image_url;

    @Schema(description = "Type of question")
    private String type;

    @Schema(description = "Time available to answer the question")
    private Long time_second;

    @Schema(description = "Question")
    private String question;

    @Schema(description = "Identifying the correct answer")
    private String correct_answer;

    @Schema(description = "List of possible answers")
    private List<AnswerDto> answers;

}
