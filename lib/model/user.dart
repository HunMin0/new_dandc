
import 'package:Deal_Connect/model/user_business.dart';
import 'package:Deal_Connect/model/user_keyword.dart';
import 'package:Deal_Connect/model/user_profile.dart';

class User {
  final int id;
  final String name;
  final String user_id;
  final bool is_active;
  final int? is_partner;
  final int? is_partner_of;
  final int level;
  final bool is_agree_service;
  final bool is_agree_personal;
  final bool is_agree_marketing;
  final bool is_agree_app_notification;
  final bool is_agree_app_marketing;

  final String? sns_type;
  final String? email;
  final String? phone;
  final UserProfile? profile;
  final List<UserKeyword>? has_keywords;
  final UserBusiness? main_business;

  User({
    required this.id,
    required this.name,
    required this.user_id,
    required this.level,
    this.is_partner = 0,
    this.is_partner_of = 0,
    required this.is_active,
    required this.is_agree_service,
    required this.is_agree_personal,
    required this.is_agree_marketing,
    required this.is_agree_app_notification,
    required this.is_agree_app_marketing,
    this.profile,
    this.main_business,

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

    var profile = json['profile'] != null ? UserProfile.fromJSON(json['profile']) : null;
    var main_business = json['main_business'] != null ? UserBusiness.fromJSON(json['main_business']) : null;

    return User(
      id: json['id'],
      name: json['name'],
      user_id: json['user_id'],
      email: json['email'],
      phone: json['phone'],
      level: json['level'],
      is_partner: json['is_partner'] ?? 0,
      is_partner_of: json['is_partner_of'] ?? 0,
      is_active: json['is_active'] ?? false,
      sns_type: json['sns_type'],
      profile: profile,
      main_business: main_business,
      has_keywords: has_keywords,
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
      'main_business': main_business?.toJson(),
      'has_keywords': has_keywords?.map((keyword) => keyword.toJson()).toList(),
      'profile': profile?.toJson(),
      'is_agree_service': is_agree_service,
      'is_agree_personal': is_agree_personal,
      'is_agree_marketing': is_agree_marketing,
      'is_agree_app_notification': is_agree_app_notification,
      'is_agree_app_marketing': is_agree_app_marketing,
    };
  }
}