package it.unisa.emad.feeltheart.dao;

import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.QuerySnapshot;
import com.google.firebase.cloud.FirestoreClient;
import it.unisa.emad.feeltheart.constant.LogMessage;
import it.unisa.emad.feeltheart.dto.question.GetQuestionByTypeRequestDto;
import it.unisa.emad.feeltheart.dto.question.InsertQuestionRequestDto;
import it.unisa.emad.feeltheart.dto.question.QuestionDto;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Repository;

import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.concurrent.ExecutionException;

@Log4j2
@Repository(value = "QuestionDaoImpl")
public class QuestionDaoImpl implements QuestionDao{

    private static final String QUESTION_COLLECTION = "Question";

    @Override
    public String insertQuestion(InsertQuestionRequestDto request) throws ExecutionException, InterruptedException {
        log.info(LogMessage.START);

        Firestore dbFirestore = FirestoreClient.getFirestore();
        ApiFuture<DocumentReference> addedDocRef = dbFirestore
                .collection(QUESTION_COLLECTION)
                .add(request);

        log.info(LogMessage.END);
        return addedDocRef.get().getId();
    }

    @Override
    public QuestionDto getQuestionById(String questionId) throws ExecutionException, InterruptedException {
        log.info(LogMessage.START);

        Firestore dbFirestore = FirestoreClient.getFirestore();

        DocumentSnapshot document = dbFirestore
                .collection(QUESTION_COLLECTION)
                .document(questionId)
                .get()
                .get();

        log.info(LogMessage.END);
        return document.toObject(QuestionDto.class);
    }

    @Override
    public QuestionDto getRandomQuestion() throws ExecutionException, InterruptedException, NoSuchAlgorithmException {
        log.info(LogMessage.START);

        Firestore dbFirestore = FirestoreClient.getFirestore();
        DocumentSnapshot result = null;

        QuerySnapshot document = dbFirestore
                .collection(QUESTION_COLLECTION)
                .limit(50)
                .get()
                .get();

        Random rand = SecureRandom.getInstanceStrong();
        int randomIndex = rand.nextInt(document.getDocuments().size());
        result = document.getDocuments().get(randomIndex);

        log.info(LogMessage.END);
        return result.toObject(QuestionDto.class);
    }

    @Override
    public List<QuestionDto> getQuestionByType(GetQuestionByTypeRequestDto request) throws ExecutionException, InterruptedException {
        log.info(LogMessage.START);

        Firestore dbFirestore = FirestoreClient.getFirestore();
        List<QuestionDto> result = new ArrayList<>();

        QuerySnapshot documentSnapshots = dbFirestore
                .collection(QUESTION_COLLECTION)
                .whereEqualTo("type", request.getType())
                .get()
                .get();

        documentSnapshots.forEach(document -> result.add(document.toObject(QuestionDto.class)));

        log.info(LogMessage.END);
        return result;
    }
}
