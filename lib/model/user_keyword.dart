import 'package:Deal_Connect/model/file.dart';

class UserKeyword {
  final int id;
  final int user_id;
  final String keyword;

  UserKeyword({
    required this.id,
    required this.user_id,
    required this.keyword,
  });

  factory UserKeyword.fromJSON(Map<String, dynamic> json) {

    return UserKeyword(
        id: json['id'],
        user_id: json['user_id'],
        keyword: json['keyword'],
    );
  }
}