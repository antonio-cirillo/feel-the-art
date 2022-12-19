package it.unisa.emad.feeltheart.dao;

import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.QuerySnapshot;
import com.google.firebase.cloud.FirestoreClient;
import it.unisa.emad.feeltheart.constant.LogMessage;
import it.unisa.emad.feeltheart.dto.card.CardDto;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutionException;

@Log4j2
@Repository(value = "CardDaoImpl")
public class CardDaoImpl implements CardDao{

    private static final String CARD_COLLECTION = "Card";

    @Override
    public void insertCard(CardDto request) throws ExecutionException, InterruptedException {
        log.info(LogMessage.START);

        long cardId = request.getId();

        Firestore dbFirestore = FirestoreClient.getFirestore();
        dbFirestore
                .collection(CARD_COLLECTION)
                .document(String.valueOf(cardId))
                .create(request)
                .get();

        log.info(LogMessage.END);
    }

    @Override
    public List<CardDto> getAllCards() throws ExecutionException, InterruptedException {
        log.info(LogMessage.START);

        Firestore dbFirestore = FirestoreClient.getFirestore();
        List<CardDto> result = new ArrayList<>();

        QuerySnapshot documentSnapshots = dbFirestore
                .collection(CARD_COLLECTION)
                .get()
                .get();

        documentSnapshots.forEach(document -> result.add(document.toObject(CardDto.class)));

        log.info(LogMessage.END);
        return result;
    }
}
