
class User {
  final int id;
  final String name;
  final String? email;
  final String? phone;
  final String? tel;
  final String? addr;
  final String? addr_detail;
  final String? post;
  final bool is_active;
  final String? sns_type;
  final bool is_admin;
  final bool is_agree_service;
  final bool is_agree_personal;
  final bool is_agree_marketing;
  final bool is_agree_app_notification;
  final bool is_agree_app_marketing;

  User({
    required this.id,
    required this.name,
    this.email,
    this.phone,
    this.tel,
    this.addr,
    this.addr_detail,
    this.post,
    required this.is_active,
    this.sns_type,
    required this.is_admin,
    required this.is_agree_service,
    required this.is_agree_personal,
    required this.is_agree_marketing,
    required this.is_agree_app_notification,
    required this.is_agree_app_marketing,
  });

  factory User.fromJSON(Map<String, dynamic> json) {

    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      tel: json['tel'],
      addr: json['addr'],
      addr_detail: json['addr_detail'],
      post: json['post'],
      is_active: json['is_active'],
      sns_type: json['sns_type'],
      is_admin: json['is_admin'] ?? false,
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
      'name': name,
      'email': email,
      'phone': phone,
      'tel': tel,
      'addr': addr,
      'addr_detail': addr_detail,
      'post': post,
      'is_active': is_active,
      'sns_type': sns_type,
      'is_admin': is_admin,
      'is_agree_service': is_agree_service,
      'is_agree_personal': is_agree_personal,
      'is_agree_marketing': is_agree_marketing,
      'is_agree_app_notification': is_agree_app_notification,
      'is_agree_app_marketing': is_agree_app_marketing,
    };
  }
}