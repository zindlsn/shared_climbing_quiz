import 'package:enum_to_string/enum_to_string.dart';
import 'package:shared_climbing_quiz/shared_climbing_quiz.dart';

class SingleChoiceQuestion extends Question {
  Solution solution = Solution();
  bool? isFriendMode;

  SingleChoiceQuestion(
      {required String content,
      required Topic topic,
      required this.isFriendMode,
      required isActive})
      : super(content, topic, isActive) {
    questionType = QuestionType.SingleChoice;
  }

  Map<String, dynamic> toJson() => {
        'isActive': isActive,
        'questionType':
            EnumToString.convertToString(questionType, camelCase: true),
        'topic': EnumToString.convertToString(topic, camelCase: true),
        'content': content,
        'isFriendMode': isFriendMode,
        'createdTime': createdAt.toString(),
        'solution': solution.toJson()
      };

  static fromJson(Map<String, dynamic> parsedJson) {
    return SingleChoiceQuestion(
        content: parsedJson['content'],
        isActive: parsedJson['isActive'] as bool,
        isFriendMode: parsedJson['isFriendMode'] as bool?,
        topic: EnumToString.fromString(Topic.values, parsedJson['topic'],
            camelCase: true)!)
      ..solution = Solution.fromJson(parsedJson['solution']);
  }
}
