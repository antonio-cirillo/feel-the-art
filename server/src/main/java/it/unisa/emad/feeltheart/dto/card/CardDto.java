package it.unisa.emad.feeltheart.dto.card;

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
public class CardDto implements Serializable {

    @Serial
    private static final long serialVersionUID = 5516847853702553599L;

    @Schema(description = "Identificativo univoco della carta")
    private Long id;

    @Schema(description = "Titolo dell'opera raffigurata")
    private String title;

    @Schema(description = "Autore dell'opera raffigurata")
    private String author;

    @Schema(description = "")
    private String date;

    @Schema(description = "Museo in cui è esposta l'opera raffigurata")
    private String museum;

    @Schema(description = "Breve descrizione dell'opera raffigurata")
    private String description;

    public void setAll(Object obj) {
        if(obj instanceof InsertCardRequestDto card){
            this.setId(card.getId());
            this.setTitle(card.getTitle());
            this.setAuthor(card.getAuthor());
            this.setDate(card.getDate());
            this.setMuseum(card.getMuseum());
            this.setDescription(card.getDescription());
        }
    }
}
