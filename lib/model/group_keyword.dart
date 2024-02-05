import 'package:Deal_Connect/model/file.dart';

class GroupKeyword {
  final int id;
  final int group_id;
  final String keyword;

  GroupKeyword({
    required this.id,
    required this.group_id,
    required this.keyword,
  });

  factory GroupKeyword.fromJSON(Map<String, dynamic> json) {

    return GroupKeyword(
      id: json['id'],
      group_id: json['group_id'],
      keyword: json['keyword'],
    );
  }
}