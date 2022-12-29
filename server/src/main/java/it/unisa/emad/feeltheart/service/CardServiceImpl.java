package it.unisa.emad.feeltheart.service;

import it.unisa.emad.feeltheart.constant.LogMessage;
import it.unisa.emad.feeltheart.dao.CardDao;
import it.unisa.emad.feeltheart.dto.card.CardDto;
import it.unisa.emad.feeltheart.dto.card.InsertCardRequestDto;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;

@Log4j2
@Service(value = "CardServiceImpl")
public class CardServiceImpl implements CardService{

    private final CardDao cardDao;

    @Autowired
    public CardServiceImpl(CardDao cardDao) {
        this.cardDao = cardDao;
    }

    @Override
    public Long insertCard(InsertCardRequestDto request) {
        log.info(LogMessage.START);

        Long cardId = request.getId();

        CardDto cardToInsert = new CardDto();

        cardToInsert.setAll(request);

        try {
            cardDao.insertCard(cardToInsert);

            log.info(LogMessage.END);
            return cardId;
        }catch (InterruptedException e){
            log.warn(LogMessage.INTERRUPTED_EXCEPTION, e.getMessage());
            Thread.currentThread().interrupt();
            return null;
        }
        catch (Exception e){
            log.error(LogMessage.ERROR, e.getMessage());
            return null;
        }
    }

    @Override
    public List<CardDto> getAllCards() {
        log.info(LogMessage.START);

        try {
            List<CardDto> result = cardDao.getAllCards();

            log.info(LogMessage.END);
            return result;
        } catch (InterruptedException e){
            log.warn(LogMessage.INTERRUPTED_EXCEPTION, e.getMessage());
            Thread.currentThread().interrupt();
            return Collections.emptyList();
        }
        catch (Exception e){
            log.error(LogMessage.ERROR, e.getMessage());
            return Collections.emptyList();
        }
    }

}
