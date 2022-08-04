part of 'models.dart';

class QuizQuestionModel extends Equatable {
  const QuizQuestionModel({
    this.id,
    this.documentId,
    this.question,
    this.options,
    this.quizId,
  });

  final int? id;
  final int? documentId;
  final String? question;
  final List<QuizOptionModel>? options;
  final int? quizId;

  factory QuizQuestionModel.fromJson(Map<String, dynamic> json) =>
      QuizQuestionModel(
        id: json["id"],
        documentId: json["document_id"],
        question: json["question"],
        options: List<QuizOptionModel>.from(
            json["options"].map((x) => QuizOptionModel.fromJson(x))),
        quizId: json["quiz_id"],
      );

  Map<String, dynamic> toJson(QuizQuestionModel questionModel) => {
        "id": id,
        "document_id": documentId,
        "question": question,
        "options": List<QuizOptionModel>.from(options!.map((x) => x.toJson())),
        "quiz_id": quizId,
      };

  @override
  List<Object?> get props => [
        id,
        documentId,
        question,
        options,
        quizId,
      ];
}
