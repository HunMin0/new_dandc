import 'package:Deal_Connect/model/file.dart';
import 'package:Deal_Connect/model/group_keyword.dart';

class Group {
  final int id;

  final String name;
  final File? has_group_image;
  final GroupKeyword? has_keywords;

  final int? group_image_id;
  final String? description;
  final DateTime? created_at;
  final DateTime? updated_at;

  Group({
    required this.id,
    this.group_image_id,
    required this.name,
    this.description,
    this.has_group_image,
    this.has_keywords,
    required this.created_at,
    required this.updated_at,
  });

  factory Group.fromJSON(Map<String, dynamic> json) {
    var has_group_image = json['group_image_id'] != null ? File.fromJSON(json['has_group_image']) : null;

    var has_keywords = null;
    if (json['has_keywords'] != null) {
      Iterable iterable = json['has_keywords'];
      List<GroupKeyword> list = List<GroupKeyword>.from(iterable.map((e) => GroupKeyword.fromJSON(e)));
      has_keywords = list;
    }

    return Group(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        group_image_id: json['group_image_id'],
        created_at: json['created_at'],
        updated_at: json['updated_at'],
        has_keywords: has_keywords,
        has_group_image: has_group_image
    );
  }
}