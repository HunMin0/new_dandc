import 'package:Deal_Connect/model/user.dart';

class BoardWriteComment {
  final int id;
  final int board_write_id;
  final String comment;
  final int comment_user_id;
  final String created_at;
  final String updated_at;
  final User? has_writer;

  BoardWriteComment({
    required this.id,
    required this.board_write_id,
    required this.comment,
    required this.comment_user_id,
    this.has_writer,
    required this.created_at,
    required this.updated_at,
  });

  factory BoardWriteComment.fromJSON(Map<String, dynamic> json) {

    var has_writer = null;
    if (json['has_writer'] != null && json['has_writer'] != null) {
      has_writer = User.fromJSON(json['has_writer']);
    }


    return BoardWriteComment(
        id: json['id'],
        board_write_id: json['board_write_id'],
        comment: json['comment'],
        comment_user_id: json['comment_user_id'],
        created_at: json['created_at'],
        updated_at: json['updated_at'],
        has_writer: has_writer,
    );
  }
}