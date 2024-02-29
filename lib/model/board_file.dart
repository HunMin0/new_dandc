import 'package:Deal_Connect/model/file.dart';

class BoardFile {
  final int id;
  final int board_id;
  final int board_write_id;
  final int file_id;
  final File? has_file;

  BoardFile({
    required this.id,
    required this.board_id,
    required this.board_write_id,
    required this.file_id,
    required this.has_file,
  });

  factory BoardFile.fromJSON(Map<String, dynamic> json) {
    var has_file = json['has_file'] != null ? File.fromJSON(json['has_file']) : null;

    return BoardFile(
        id: json['id'],
        board_id: json['board_id'],
        board_write_id: json['board_write_id'],
        file_id: json['file_id'],
        has_file: has_file
    );
  }
}