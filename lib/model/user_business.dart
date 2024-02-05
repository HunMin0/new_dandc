import 'package:Deal_Connect/model/file.dart';

class UserBusiness {
  final int id;

  final String name;
  final File? has_group_image;

  final int? group_image_id;
  final String? description;
  final DateTime? created_at;
  final DateTime? updated_at;

  UserBusiness({
    required this.id,
    this.group_image_id,
    required this.name,
    this.description,
    this.has_group_image,
    required this.created_at,
    required this.updated_at,
  });

  factory UserBusiness.fromJSON(Map<String, dynamic> json) {
    var has_group_image = json['group_image_id'] != null ? File.fromJSON(json['has_group_image']) : null;

    return UserBusiness(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        group_image_id: json['group_image_id'],
        created_at: json['created_at'],
        updated_at: json['updated_at'],
        has_group_image: has_group_image
    );
  }
}