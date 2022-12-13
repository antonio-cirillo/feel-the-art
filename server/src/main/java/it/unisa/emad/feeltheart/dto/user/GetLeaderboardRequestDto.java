package it.unisa.emad.feeltheart.dto.user;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.google.gson.annotations.SerializedName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import java.io.Serial;
import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
@JsonInclude(JsonInclude.Include.NON_ABSENT)
public class GetLeaderboardRequestDto implements Serializable {

    @Serial
    private static final long serialVersionUID = -3246609639587070697L;

    @NotNull(message = "Il campo startRange non è valorizzato")
    @Min(value = 1, message = "Il valore di start_range deve essere maggiore o uguale a 1")
    @SerializedName(value = "start_range")
    private Long start_range;

    @NotNull(message = "Il campo end_range non è valorizzato")
    @Min(value = 1, message = "Il valore di end_range deve essere maggiore o uguale a 1")
    @SerializedName(value = "end_range")
    private Long end_range;
}
