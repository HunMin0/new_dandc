import 'package:Deal_Connect/model/user.dart';

class GroupUser {
  final int id;
  final int group_id;
  final int user_id;
  final bool is_leader;
  final bool? is_approved;
  final String? return_reason;
  final String? processed_at;
  final User? has_user;

  GroupUser({
    required this.id,
    required this.group_id,
    required this.user_id,
    required this.is_leader,
    this.is_approved,
    this.return_reason,
    this.processed_at,
    this.has_user,
  });

  factory GroupUser.fromJSON(Map<String, dynamic> json) {
    var has_user = json['user_id'] != null ? User.fromJSON(json['has_user']) : null;


    return GroupUser(
      id: json['id'],
      group_id: json['group_id'],
      user_id: json['user_id'],
      is_leader: json['is_leader'],
      is_approved: json['is_approved'],
      return_reason: json['return_reason'],
      processed_at: json['processed_at'],
      has_user: has_user,
    );
  }
}