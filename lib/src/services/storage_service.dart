import 'dart:convert';

import 'package:shared_climbing_quiz/src/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static final LocalStorageService _instance = LocalStorageService._internal();

  factory LocalStorageService() {
    return _instance;
  }

  LocalStorageService._internal();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<bool> saveQuestionsToLocalAsync(String questionsAsJson) async {
    final SharedPreferences prefs = await _prefs;
    return await prefs.setString(kLocalStorageQuestionId, questionsAsJson);
  }

  Future<bool> saveLastQuestionNumber(int number) async {
    final SharedPreferences prefs = await _prefs;
    return await prefs.setInt('lastQuestionNumber', number);
  }

  Future<int?> loadLastQuestionNumber() async {
    final SharedPreferences prefs = await _prefs;
    int? savedNumber = prefs.getInt('lastQuestionNumber');
    print(savedNumber);
    return await Future.value(savedNumber);
  }

  Future<String?> loadQuestionsFromLocalAsJsonAsync() async {
    final SharedPreferences prefs = await _prefs;
    if (prefs.containsKey(kLocalStorageQuestionId)) {
      return Future.value(prefs.getString(kLocalStorageQuestionId));
    } else {
      return null;
    }
  }


  Future<bool> hasQuestionsSavedAsync() async {
    final SharedPreferences prefs = await _prefs;
    bool hasSaved = await prefs.containsKey(kLocalStorageQuestionId);
    return Future.value(hasSaved);
  }
}
