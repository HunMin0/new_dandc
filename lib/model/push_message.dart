import 'package:Deal_Connect/model/user.dart';

class PushMessage {
  final int id;
  final String title;
  final String content;
  final int? user_id;
  final String? route;
  final String? key;
  final String? keyValue;
  final String? topic;
  final String? token;
  final String created_at;
  final String updated_at;
  final User? has_user;

  PushMessage({
    required this.id,
    required this.title,
    required this.content,
    this.user_id,
    this.route,
    this.key,
    this.keyValue,
    this.topic,
    this.token,
    this.has_user,
    required this.created_at,
    required this.updated_at,
  });

  factory PushMessage.fromJSON(Map<String, dynamic> json) {
    var has_user = json['has_user'] != null ? User.fromJSON(json['has_user']) : null;

    return PushMessage(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      user_id: json['user_id'],
      route: json['route'],
      key: json['key'],
      keyValue: json['keyValue'],
      topic: json['topic'],
      token: json['token'],
      has_user: has_user,
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
}
