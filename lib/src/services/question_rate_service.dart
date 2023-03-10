import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_climbing_quiz/shared_climbing_quiz.dart';

class QuestionRateService {
  Future<bool> rateQuestion(QuestionRating questionRating) async {
    final db = FirebaseFirestore.instance;
    DocumentReference document = await db!
        .collection('questions')
        .doc(questionRating.questionId)
        .collection('questionRatings')
        .add(questionRating.toJson());
    return document.id != null;
  }

  Future<bool> saveRateAnswer(AnswerRating answerRating) async {
    final db = FirebaseFirestore.instance;
    DocumentReference document = await db!
        .collection('questions')
        .doc(answerRating.questionId)
        .collection('answerRatings')
        .add(answerRating.toJson());
    return document.id != null;
  }

  Future<bool> getIsRatingActive() async {
    final db = FirebaseFirestore.instance;
    DocumentSnapshot<Map<String, dynamic>> parameters =
        await db!.collection('globalParameters').doc('rating').get();
    return Future.value(parameters['isActive'] as bool);
  }
}
