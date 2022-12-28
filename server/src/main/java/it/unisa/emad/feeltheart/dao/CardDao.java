package it.unisa.emad.feeltheart.dao;

import it.unisa.emad.feeltheart.dto.card.CardDto;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.concurrent.ExecutionException;

@Repository
public interface CardDao {

    void insertCard(CardDto request) throws ExecutionException, InterruptedException;

    List<CardDto> getAllCards() throws ExecutionException, InterruptedException;

}
