import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_climbing_quiz/shared_climbing_quiz.dart';
import 'package:shared_climbing_quiz/src/globals.dart';
import 'package:shared_climbing_quiz/src/services/storage_service.dart';

class QuestionService {
  FirebaseFirestore? db = FirebaseFirestore.instance;
  LocalStorageService storageService = LocalStorageService();

  Future addSimpleQuestion(SelectQuestion question) async {
    DocumentReference document = await db!.collection(kQuestionTable).add(
        question.toJson());
    await db!.collection(kQuestionTable).doc(document.id).update(
        {"answers": question.answer.toJson()});
  }

  Future deleteQuestion(String id) async {
    await db!.collection(kQuestionTable).doc(id).delete();
  }

  Future<List<SelectQuestion>> getAllQuestionsAsync() async {
    List<SelectQuestion> result = [];
    if (true) {
      try {
        final db = FirebaseFirestore.instance;
        QuerySnapshot<Map<String, dynamic>> questionsDocs = await db.collection(
            kQuestionTable).orderBy('createdTime', descending: true).get();
        if (kDebugMode) {
          print(questionsDocs.size);
        }
        int i = 0;
        for (var doc in questionsDocs.docs) {
          if (kDebugMode) {
            if (doc.id.startsWith('NtvI')) {
              print(doc.id);
            }
            if(i == 29){
              print(doc.id);
            }
            i++;
          }
          SelectQuestion sq = SelectQuestion.fromJson(doc.data());
          sq.id = doc.id;
          // var aws = await db.collection(kQuestionTable).doc(doc.id).path('answers').get();
          // sq.answer = Answer.fromJson(aws.docs.first.data());
          result.add(sq);
        }

        var json = jsonEncode(result.map((e) => e.toJson()).toList());
        if (await storageService.saveQuestionsToLocalAsync(jsonEncode(json))) {
          print('saved');
        }
        print('from online loaded');
      } catch (ex) {
        if (kDebugMode) {
          print(ex);
        }
      }
    } else {
      String? questionsAsString = await storageService
          .loadQuestionsFromLocalAsJsonAsync();
      if (questionsAsString != null) {
        List<dynamic> parsedListJson = jsonDecode(questionsAsString);
        result = List<SelectQuestion>.from(
            parsedListJson.map<SelectQuestion>((dynamic i) =>
                SelectQuestion.fromJson(i)));
        print('from local loaded');
      }
    }
    return result;
  }

  Future<bool> updateQuestionAsync(SelectQuestion question) async {
    final db = FirebaseFirestore.instance;
    final questionDocument = db.collection(kQuestionTable).doc(question.id);
    questionDocument.set(question.toJson());
    db.collection(kQuestionTable).doc(question.id).update(
        {"answers": question.answer.toJson()});
    return Future.value(true);
  }
}
