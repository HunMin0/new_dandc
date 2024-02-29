import 'package:Deal_Connect/model/file.dart';
import 'package:Deal_Connect/model/group_keyword.dart';

class Group {
  final int id;

  final String name;
  final File? has_group_image;
  final List<GroupKeyword>? has_keywords;

  final int? group_image_id;
  final int? approved_users_count;
  final int? un_approved_users_count;
  final int? price_sum;
  final String? description;
  final String? created_at;
  final String? updated_at;
  final bool? is_leader;
  final bool? is_member;

  Group({
    required this.id,
    this.group_image_id,
    required this.name,
    this.is_leader,
    this.is_member,
    this.description,
    this.approved_users_count,
    this.un_approved_users_count,
    this.price_sum,
    this.has_group_image,
    this.has_keywords,
    required this.created_at,
    required this.updated_at,
  });

  factory Group.fromJSON(Map<String, dynamic> json) {
    var has_group_image = json['has_group_image'] != null ? File.fromJSON(json['has_group_image']) : null;

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
        approved_users_count: json['approved_users_count'],
        un_approved_users_count: json['un_approved_users_count'],
        price_sum: json['price_sum'],
        is_leader: json['is_leader'],
        is_member: json['is_member'],
        has_keywords: has_keywords,
        has_group_image: has_group_image
    );
  }
}