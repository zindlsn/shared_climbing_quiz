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
    return await prefs.setString('questionsAsJson', questionsAsJson);
  }

  Future<String?> loadQuestionsFromLocalAsJsonAsync() async {
    final SharedPreferences prefs = await _prefs;
    if (prefs.containsKey('questionsAsJson')) {
      return Future.value(prefs.getString('questionsAsJson'));
    } else {
      return null;
    }
  }

  Future<bool> hasQuestionsSavedAsync() async {
    final SharedPreferences prefs = await _prefs;
    bool hasSaved = await prefs.containsKey('questionsAsJson');
    return Future.value(hasSaved);
  }
}
