import 'package:Deal_Connect/model/board_write.dart';
import 'package:Deal_Connect/model/file.dart';

class Board {
  final int id;
  final int group_id;
  final List<BoardWrite>? has_board_write;

  Board({
    required this.id,
    required this.group_id,
    this.has_board_write,
  });

  factory Board.fromJSON(Map<String, dynamic> json) {

    var has_board_write = null;
    if (json['has_board_write'] != null) {
      Iterable iterable = json['has_board_write'];
      List<BoardWrite> list = List<BoardWrite>.from(iterable.map((e) => BoardWrite.fromJSON(e)));
      has_board_write = list;
    }

    return Board(
        id: json['id'],
        group_id: json['group_id'],
        has_board_write: has_board_write
    );
  }
}