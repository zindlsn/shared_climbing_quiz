import 'package:enum_to_string/enum_to_string.dart';

class QuestionRating {
  String questionId;
  int difficultRating = 0;
  bool? likedQuestion;
  String comment;

  QuestionRating(
      {required this.questionId,
      required this.difficultRating,
      required this.likedQuestion,
      required this.comment});

  Map<String, dynamic> toJson() => {
        'questionId': questionId,
        'difficultRating': difficultRating,
        'likedQuestion': likedQuestion,
        'comment': comment,
      };

  static fromJson(Map<String, dynamic> parsedJson) {
    return QuestionRating(
        questionId: parsedJson['questionId'],
        difficultRating: parsedJson['difficultRating'],
        likedQuestion: parsedJson['likedQuestion'],
        comment: parsedJson['comment']);
  }
}
