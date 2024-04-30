import 'package:Deal_Connect/model/user.dart';

class Qna {
  final int id;
  final int question_user_id;
  final int? answer_user_id;
  final String title;
  final String question;
  final String email;
  final String? answer;
  final bool has_answer;
  final String? created_at;
  final String? updated_at;
  final User? has_user;

  Qna({
    required this.id,
    required this.question_user_id,
    required this.title,
    required this.question,
    required this.email,
    required this.has_answer,
    this.answer,
    this.answer_user_id,
    this.has_user,
    required this.created_at,
    required this.updated_at,
  });

  factory Qna.fromJSON(Map<String, dynamic> json) {
    var has_user = json['has_user'] != null ? User.fromJSON(json['has_user']) : null;

    return Qna(
      id: json['id'],
      question_user_id: json['question_user_id'],
      title: json['title'],
      question: json['question'],
      email: json['email'],
      has_answer: json['has_answer'],
      answer: json['answer'],
      answer_user_id: json['answer_user_id'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
}
