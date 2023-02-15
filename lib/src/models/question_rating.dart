import 'package:enum_to_string/enum_to_string.dart';
import 'package:shared_climbing_quiz/src/models/globals.dart';
import 'package:shared_climbing_quiz/src/models/question_understanding.dart';

class QuestionRating {
  String questionId;
  int difficultRating = 0;
  bool? likedQuestion;
  String comment;
  late QuestionUnderstanding? questionUnderstanding;
  late DateTime createdAt;

  QuestionRating(
      {required this.questionId,
      required this.difficultRating,
      required this.likedQuestion,
      required this.comment}) {
    createdAt = DateTime.now();
  }

  Map<String, dynamic> toJson() => {
        'questionId': questionId,
        'difficultRating': difficultRating,
        'likedQuestion': likedQuestion,
        'comment': comment,
        'createdAt': createdAt.toString(),
        'questionUnderstanding':
            EnumToString.convertToString(questionUnderstanding,camelCase: true)
      };

  static fromJson(Map<String, dynamic> parsedJson) {
    return QuestionRating(
      questionId: parsedJson['questionId'],
      difficultRating: parsedJson['difficultRating'] as int,
      likedQuestion: parsedJson['likedQuestion'] as bool,
      comment: parsedJson['comment'],
    )
      ..createdAt = DateTime.parse(parsedJson['createdAt'])
      ..questionUnderstanding = EnumToString.fromString(
          QuestionUnderstanding.values, parsedJson['questionUnderstanding']);
  }
}
