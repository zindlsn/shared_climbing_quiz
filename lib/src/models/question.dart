import 'package:enum_to_string/enum_to_string.dart';
import 'package:shared_climbing_quiz/src/models/level.dart';
import 'package:shared_climbing_quiz/src/models/question_rating.dart';
import 'package:shared_climbing_quiz/src/models/question_type.dart';
import 'package:shared_climbing_quiz/src/models/topic.dart';

class Question {
  late String id;
  late String quizId;
  late QuestionType questionType = QuestionType.Select;
  bool isActive = true;
  late Level level;
  late Topic topic;
  late int score;
  late DateTime createdAt;
  late DateTime updatedAt;
  String content;

  late List<QuestionRating> ratings = [];

  Question(this.content, this.topic, this.isActive) {
    createdAt = DateTime.now();
  }

  Map toJson() => {
        'isActive': isActive,
        'questionType':
            EnumToString.convertToString(questionType, camelCase: true),
        'topic': EnumToString.convertToString(topic, camelCase: true),
        'content': content,
        'createdTime': createdAt.toString()
      };
}
