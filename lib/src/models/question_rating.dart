import 'package:enum_to_string/enum_to_string.dart';
import 'package:shared_climbing_quiz/src/models/level.dart';

class QuestionRating {
  String questionId;
  Level rateLevel = Level.None;
  bool? likedQuestion;
  String comment;

  QuestionRating(
      {required this.questionId,
      required this.rateLevel,
      required this.likedQuestion,
      required this.comment});

  Map<String, dynamic> toJson() => {
        'questionId': questionId,
        'rateLevel': EnumToString.convertToString(rateLevel, camelCase: true),
        'likedQuestion': likedQuestion,
        'comment': comment,
      };

  static fromJson(Map<String, dynamic> parsedJson) {
    return QuestionRating(
        questionId: parsedJson['questionId'],
        rateLevel:
            EnumToString.fromString(Level.values, parsedJson['rateLevel'])!,
        likedQuestion: parsedJson['likedQuestion'],
        comment: parsedJson['comment']);
  }
}
