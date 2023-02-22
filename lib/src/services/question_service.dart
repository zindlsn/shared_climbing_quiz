import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_climbing_quiz/shared_climbing_quiz.dart';
import 'package:shared_climbing_quiz/src/services/storage_service.dart';

class QuestionService {
  FirebaseFirestore? db = FirebaseFirestore.instance;
  LocalStorageService storageService = LocalStorageService();

  int? lastQuestionNumber;

  Future addSimpleQuestion(SelectQuestion question) async {
    DocumentReference document =
        await db!.collection("questions").add(question.toJson());
    await db!
        .collection('questions')
        .doc(document.id)
        .collection('answers')
        .add(question.answer.toJson());
  }

  Future<void> deleteQuestion(String id) async {
    await db!.collection('questions').doc(id).delete();
  }

  Future saveLastQuestionNumber(int id) async {
    bool questionNumberSavedSuccessfully =
        await storageService.saveLastQuestionNumber(id);
    print(questionNumberSavedSuccessfully);
  }

  Future<void> loadLastQuestionNumber() async {
    lastQuestionNumber = await storageService.loadLastQuestionNumber();
  }

  Future<List<SelectQuestion>> getAllQuestionsAsync({bool onlyActive = false}) async {
    List<SelectQuestion> result = [];
    if (!await storageService.hasQuestionsSavedAsync()) {
      try {
        final db = FirebaseFirestore.instance;
        Query<Map<String, dynamic>> questionsDocs = await db
            .collection("questions")
            .orderBy('createdTime', descending: true);

        if (onlyActive) {
          questionsDocs.where('isActive', isEqualTo: onlyActive);
        }

        QuerySnapshot<Map<String, dynamic>> docs = await questionsDocs.get();
        if (kDebugMode) {
          print(docs.size);
        }
        for (var doc in docs.docs) {
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
        print('from online loaded');
      } catch (ex) {
        if (kDebugMode) {
          print(ex);
        }
      }
    } else {
      String? questionsAsString =
          await storageService.loadQuestionsFromLocalAsJsonAsync();
      if (questionsAsString != null) {
        //  results =  (json.decode(questionsAsString!) as List).map((i) =>
        //     SelectQuestion.fromJson(i)).toList();
        try {
          //  final List<dynamic> dataList = jsonDecode(questionsAsString!);
          //print(dataList[0]); // {text: foo, value: 1, status: true}
          //  print(dataList[1]); // {text: bar, value: 2, status: false}
          // print('from local loaded');
        } catch (ex) {
          print(ex);
        }
      }
    }
    return result;
  }

  Future<bool> updateQuestionAsync(SelectQuestion question) async {
    final db = FirebaseFirestore.instance;
    final questionDocument = db.collection("questions").doc(question.id);
    await questionDocument.set(question.toJson());
    await questionDocument.collection('answers').doc().set(
        question.answer.toJson());
    return Future.value(true);
  }
}
