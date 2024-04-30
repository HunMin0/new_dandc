import 'package:Deal_Connect/model/board_write.dart';
import 'package:Deal_Connect/model/group.dart';

class Board {
  final int id;
  final int group_id;
  final Group? has_group;
  final List<BoardWrite>? has_board_write;

  Board({
    required this.id,
    required this.group_id,
    this.has_board_write,
    this.has_group,
  });

  factory Board.fromJSON(Map<String, dynamic> json) {
    var has_group = null;
    if (json['has_group'] != null && json['has_group'] != null) {
      has_group = Group.fromJSON(json['has_group']);
    }
    var has_board_write = null;
    if (json['has_board_write'] != null) {
      Iterable iterable = json['has_board_write'];
      List<BoardWrite> list = List<BoardWrite>.from(iterable.map((e) => BoardWrite.fromJSON(e)));
      has_board_write = list;
    }

    return Board(
        id: json['id'],
        group_id: json['group_id'],
        has_board_write: has_board_write,
        has_group: has_group
    );
  }
}