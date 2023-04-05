part of 'models.dart';

class QuizGetScoreModel {
  int? userId;
  int? score;
  UserModel? userModel;

  QuizGetScoreModel({
    this.userId,
    this.score,
    this.userModel,
  });

  factory QuizGetScoreModel.fromJson(Map<String, dynamic> json) =>
      QuizGetScoreModel(
        userId: json['user_id'],
        score: json['highestValue'],
        userModel:
            json['user'] == null ? null : UserModel.fromJson(json['user']),
      );
}
