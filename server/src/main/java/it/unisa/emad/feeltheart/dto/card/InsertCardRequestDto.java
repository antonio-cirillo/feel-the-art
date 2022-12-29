package it.unisa.emad.feeltheart.dto.card;

import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import java.io.Serial;
import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
@JsonInclude(JsonInclude.Include.NON_ABSENT)
public class InsertCardRequestDto implements Serializable {

    @Serial
    private static final long serialVersionUID = 3027296335189878216L;

    @Schema(description = "Identificativo univoco della carta")
    private Long id;

    @NotBlank(message = "Il campo title non è valorizzato")
    @Schema(description = "Titolo dell'opera raffigurata")
    private String title;

    @NotBlank(message = "Il campo author non è valorizzato")
    @Schema(description = "Autore dell'opera raffigurata")
    private String author;

    @NotBlank(message = "Il campo date non è valorizzato")
    @Schema(description = "Data approssimativa in cui è stata creata l'opera")
    private String date;

    @NotBlank(message = "Il campo museum non è valorizzato")
    @Schema(description = "Museo in cui è esposta l'opera raffigurata")
    private String museum;

    @NotBlank(message = "Il campo description non è valorizzato")
    @Schema(description = "Breve descrizione dell'opera raffigurata")
    private String description;
}
