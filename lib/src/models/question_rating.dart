
import 'package:shared_climbing_quiz/src/models/level.dart';

class QuestionRating {
  String questionId;
  Level rateLevel;
  bool likedQuestion;
  String comment;

  QuestionRating(
      this.questionId, this.rateLevel, this.likedQuestion, this.comment);
}
