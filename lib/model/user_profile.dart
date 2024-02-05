import 'package:Deal_Connect/model/file.dart';

class UserProfile {
  final int id;
  final int user_id;
  final int? profile_image_id;
  final File? has_profile_image;

  UserProfile({
    required this.id,
    required this.user_id,
    this.profile_image_id,
    this.has_profile_image,
  });

  factory UserProfile.fromJSON(Map<String, dynamic> json) {
    var has_profile_image = json['profile_image_id'] != null ? File.fromJSON(json['has_profile_image']) : null;

    return UserProfile(
        id: json['id'],
        user_id: json['user_id'],
        profile_image_id: json['profile_image_id'],
        has_profile_image: has_profile_image
    );
  }
}