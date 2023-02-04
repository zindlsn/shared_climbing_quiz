import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_climbing_quiz/shared_climbing_quiz.dart';

class QuestionService {
  FirebaseFirestore? db = FirebaseFirestore.instance;

  Future addSimpleQuestion(SelectQuestion question) async {
    DocumentReference document =
        await db!.collection("questions").add(question.toJson());
    await db!
        .collection('questions')
        .doc(document.id)
        .collection('answers')
        .add(question.answer.toJson());
  }

  Future deleteQuestion(String id)async{
    await db!.collection('questions').doc(id).delete();
  }

  Future<List<SelectQuestion>> getAllQuestions() async {
    List<SelectQuestion> result = [];
    try {
      final db = FirebaseFirestore.instance;
      QuerySnapshot<Map<String, dynamic>> questionsDocs =
          await db.collection("questions").orderBy('createdTime',descending: true).get();
      if (kDebugMode) {
        print(questionsDocs.size);
      }
      for (var doc in questionsDocs.docs) {
        if (kDebugMode) {}
        SelectQuestion sq = SelectQuestion.fromJson(doc.data());
        sq.id = doc.id;
        var aws = await db
            .collection('questions')
            .doc(doc.id)
            .collection('answers')
            .get();
        sq.answer = Answer.fromJson(aws.docs.first.data());
        result.add(sq);
      }
    } catch (ex) {
      if (kDebugMode) {
        print(ex);
      }
    }

    return result;
  }

  Future<bool> updateQuestionAsync(SelectQuestion question) async {
    final db = FirebaseFirestore.instance;
    final questionDocument = db.collection("questions").doc(question.id);
    questionDocument.set(question.toJson());
    return Future.value(true);
  }
}
