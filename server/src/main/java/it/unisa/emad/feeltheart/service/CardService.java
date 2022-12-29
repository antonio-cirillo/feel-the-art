package it.unisa.emad.feeltheart.service;

import it.unisa.emad.feeltheart.dto.card.CardDto;
import it.unisa.emad.feeltheart.dto.card.InsertCardRequestDto;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface CardService {

    Long insertCard(InsertCardRequestDto request);

    List<CardDto> getAllCards();
}
