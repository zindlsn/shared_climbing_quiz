class Answer {
  late bool isActive = true;
  late bool correct;
  late DateTime createdAt;
  late DateTime updatedAt;
  late String content;
  late String explanation;

  Answer() {
    createdAt = DateTime.now();
  }

  Map<String, dynamic> toJson() => {
        'isActive': isActive,
        'createdAt': createdAt.toString(),
        'content': content,
        'explanation': explanation
      };

  static fromJson(Map<String, dynamic> parsedJson) {
    return Answer()
      ..isActive = parsedJson['isActive'] as bool
      ..createdAt = DateTime.parse(parsedJson['createdAt'])
      ..content = parsedJson['content']
      ..explanation = parsedJson['explanation'];
  }
}
