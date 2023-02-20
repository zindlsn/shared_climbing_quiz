class AnswerRating {
  String questionId;
  List<String> levels;
  String comment;
  late DateTime createdAt;

  AnswerRating(
      {required this.questionId, required this.levels, required this.comment}) {
    createdAt = DateTime.now();
  }

  Map<String, dynamic> toJson() => {
        'questionId': questionId,
        'comment': comment,
        'levels': levels,
        'createdTime': createdAt.toString()
      };

  static fromJson(Map<String, dynamic> parsedJson) {
    return AnswerRating(
      questionId: parsedJson['questionId'],
        levels: parsedJson['levels'],
        comment: parsedJson['comment'])
      ..createdAt = DateTime.parse(parsedJson['createdAt']);
  }
}
