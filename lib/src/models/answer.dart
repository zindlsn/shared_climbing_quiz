import 'package:shared_climbing_quiz/src/models/answer_rating.dart';

class Answer {
  late bool correct;
  late DateTime createdAt;
  late DateTime updatedAt;
  late String content;
  late String explanation;

  late AnswerRating rating;

  Answer() {
    createdAt = DateTime.now();
    content = '';
    explanation = '';
    correct = false;
  }

  Map<String, dynamic> toJson() => {
        'createdAt': createdAt.toString(),
        'content': content,
        'explanation': explanation,
        'correct': correct
      };

  static fromJson(Map<String, dynamic> parsedJson) {
    return Answer()
      ..createdAt = DateTime.parse(parsedJson['createdAt'])
      ..content = parsedJson['content']
      ..correct = parsedJson['correct'] ?? false
      ..explanation = parsedJson['explanation'];
  }
}
