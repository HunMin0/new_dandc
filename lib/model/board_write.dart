import 'package:Deal_Connect/model/board_file.dart';
import 'package:Deal_Connect/model/file.dart';
import 'package:Deal_Connect/model/user.dart';

class BoardWrite {
  final int id;
  final int board_id;
  final int no;
  final String title;
  final String content;
  final int hits;
  final int created_user_id;
  final int updated_user_id;
  final String created_at;
  final String updated_at;
  final List<BoardFile>? has_files;
  final User? has_writer;

  BoardWrite({
    required this.id,
    required this.board_id,
    required this.no,
    required this.title,
    required this.content,
    required this.hits,
    required this.created_user_id,
    required this.updated_user_id,
    required this.created_at,
    required this.updated_at,
    this.has_files,
    this.has_writer,
  });

  factory BoardWrite.fromJSON(Map<String, dynamic> json) {
    var has_files = null;
    if (json['has_files'] != null) {
      Iterable iterable = json['has_files'];
      List<BoardFile> list = List<BoardFile>.from(iterable.map((e) => BoardFile.fromJSON(e)));
      has_files = list;
    }
    var has_writer = null;
    if (json['created_user_id'] != null && json['has_writer'] != null) {
      has_writer = User.fromJSON(json['has_writer']);
    }

    return BoardWrite(
        id: json['id'],
        board_id: json['board_id'],
        no: json['no'],
        title: json['title'],
        content: json['content'],
        hits: json['hits'],
        created_user_id: json['created_user_id'],
        updated_user_id: json['updated_user_id'],
        created_at: json['created_at'],
        updated_at: json['updated_at'],
        has_writer: has_writer,
        has_files: has_files
    );
  }
}