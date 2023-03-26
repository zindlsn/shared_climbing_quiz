import '../../shared_climbing_quiz.dart';

class Solution {
  late List<Answer> answers;
  late String explanation;

  Map<String, dynamic> toJson() => {
        'explanation': explanation,
        'answers': answers.map((e) => e.toJson()).toList()
      };

  static fromJson(Map<String, dynamic> parsedJson) {
    List<dynamic> parsedListJson = (parsedJson['answers']);
    return Solution()
      ..explanation = parsedJson['explanation']
      ..answers = List<Answer>.from(
          parsedListJson.map<Answer>((dynamic i) => Answer.fromJson(i)));
  }
}
