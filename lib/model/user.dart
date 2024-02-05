
import 'package:Deal_Connect/model/user_keyword.dart';
import 'package:Deal_Connect/model/user_profile.dart';

class User {
  final int id;
  final String name;
  final String user_id;
  final bool is_active;
  final int level;
  final bool is_agree_service;
  final bool is_agree_personal;
  final bool is_agree_marketing;
  final bool is_agree_app_notification;
  final bool is_agree_app_marketing;

  final String? sns_type;
  final String? email;
  final String? phone;
  final UserProfile?has_user_profile;
  final UserKeyword? has_keywords;

  User({
    required this.id,
    required this.name,
    required this.user_id,
    required this.level,
    required this.is_active,
    required this.is_agree_service,
    required this.is_agree_personal,
    required this.is_agree_marketing,
    required this.is_agree_app_notification,
    required this.is_agree_app_marketing,
    this.has_user_profile,

    this.has_keywords,
    this.email,
    this.phone,
    this.sns_type,
  });

  factory User.fromJSON(Map<String, dynamic> json) {

    var has_keywords = null;
    if (json['has_keywords'] != null) {
      Iterable iterable = json['has_keywords'];
      List<UserKeyword> list = List<UserKeyword>.from(iterable.map((e) => UserKeyword.fromJSON(e)));
      has_keywords = list;
    }
    var has_user_profile = json['has_user_profile'] != null ? UserProfile.fromJSON(json['has_user_profile']) : null;

    return User(
      id: json['id'],
      name: json['name'],
      user_id: json['user_id'],
      email: json['email'],
      phone: json['phone'],
      level: json['level'],
      is_active: json['is_active'],
      sns_type: json['sns_type'],
      has_user_profile: has_user_profile,
      has_keywords: json['has_keywords'],
      is_agree_service: json['is_agree_service'] ?? false,
      is_agree_personal: json['is_agree_personal'] ?? false,
      is_agree_marketing: json['is_agree_marketing'] ?? false,
      is_agree_app_notification: json['is_agree_app_notification'] ?? false,
      is_agree_app_marketing: json['is_agree_app_marketing'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
      'name': name,
      'email': email,
      'phone': phone,
      'is_active': is_active,
      'sns_type': sns_type,
      'level': level,
      'is_agree_service': is_agree_service,
      'is_agree_personal': is_agree_personal,
      'is_agree_marketing': is_agree_marketing,
      'is_agree_app_notification': is_agree_app_notification,
      'is_agree_app_marketing': is_agree_app_marketing,
    };
  }
}