import 'package:Deal_Connect/model/file.dart';

class UserKeyword {
  final int id;
  final int user_id;
  final String keyword;
  final String created_at;
  final String updated_at;

  UserKeyword({
    required this.id,
    required this.user_id,
    required this.keyword,
    required this.created_at,
    required this.updated_at,
  });

  factory UserKeyword.fromJSON(Map<String, dynamic> json) {
    return UserKeyword(
      id: json['id'],
      user_id: json['user_id'],
      keyword: json['keyword'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
}
