
///
/// The Take Answer Table can be used to store the answers selected by the user while taking the quiz.
/// In the case of a multiple-choice question, there can be multiple answers.
/// Below mentioned is the description of all the columns of the Take Answer Table.
///
class TakeAnswer{
  bool isActive;
  DateTime createdAt;
  DateTime UpdatedAt;
  String content;

  TakeAnswer(this.isActive, this.createdAt, this.UpdatedAt, this.content);
}