import 'package:Deal_Connect/model/file.dart';

class UserBusinessService {
  final int id;
  final int user_id;
  final int user_business_id;
  final String name;
  final String description;
  final int? service_image_id;
  final File? has_image;

  UserBusinessService({
    required this.id,
    required this.user_id,
    required this.user_business_id,
    required this.name,
    required this.description,
    this.service_image_id,
    this.has_image,
  });

  factory UserBusinessService.fromJSON(Map<String, dynamic> json) {
    var has_image = json['has_image'] != null ? File.fromJSON(json['has_image']) : null;

    return UserBusinessService(
      id: json['id'],
      user_id: json['user_id'],
      user_business_id: json['user_business_id'],
      name: json['name'],
      description: json['description'],
      service_image_id: json['service_image_id'],
      has_image: has_image,
    );
  }
}