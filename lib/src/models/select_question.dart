import 'package:enum_to_string/enum_to_string.dart';
import 'package:shared_climbing_quiz/shared_climbing_quiz.dart';

class SelectQuestion extends Question {
  late Answer answer;


  SelectQuestion({required String content ,
    required QuestionType questionType ,
    required Topic topic , required isActive})
      : super( content , topic , isActive );

  Map<String , dynamic> toJson() =>
      {
        'isActive': isActive ,
        'questionType': EnumToString.convertToString (
            questionType , camelCase: true ) ,
        'topic': EnumToString.convertToString ( topic , camelCase: true ) ,
        'content': content ,
        'createdTime': createdAt.toString ( )
      };

  static fromJson(Map<String , dynamic> parsedJson) {
    return SelectQuestion (
        content: parsedJson['content'] ,
        topic: EnumToString.fromString ( Topic.values , parsedJson['topic'] )! ,
        isActive: parsedJson['isActive'] ,
        questionType:
        EnumToString.fromString (
            QuestionType.values , parsedJson['questionType'] )! );
  }
}