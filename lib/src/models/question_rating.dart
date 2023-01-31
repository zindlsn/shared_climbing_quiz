class QuestionRating {
  String questionId;
  int difficultRating = 0;
  bool? likedQuestion;
  String comment;
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
        'createdAt': createdAt.toString()
      };

  static fromJson(Map<String, dynamic> parsedJson) {
    return QuestionRating(
      questionId: parsedJson['questionId'],
      difficultRating: parsedJson['difficultRating'] as int,
      likedQuestion: parsedJson['likedQuestion'] as bool,
      comment: parsedJson['comment'],
    )..createdAt = DateTime.parse(parsedJson['createdAt']);
  }
}
