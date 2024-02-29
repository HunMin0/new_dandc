import 'package:Deal_Connect/model/user.dart';

class GroupUser {
  final int id;
  final int group_id;
  final int user_id;
  final int? total_trade_amount;
  final bool is_leader;
  final bool? is_approved;
  final bool? is_deleted;
  final String? return_reason;
  final String? processed_at;
  final User? has_user;

  GroupUser({
    required this.id,
    required this.group_id,
    required this.user_id,
    required this.is_leader,
    this.total_trade_amount,
    this.is_approved,
    this.is_deleted,
    this.return_reason,
    this.processed_at,
    this.has_user,
  });

  factory GroupUser.fromJSON(Map<String, dynamic> json) {
    var has_user = json['has_user'] != null ? User.fromJSON(json['has_user']) : null;


    return GroupUser(
      id: json['id'],
      group_id: json['group_id'],
      user_id: json['user_id'],
      is_leader: json['is_leader'],
      is_approved: json['is_approved'],
      is_deleted: json['is_deleted'],
      return_reason: json['return_reason'],
      total_trade_amount: json['total_trade_amount'],
      processed_at: json['processed_at'],
      has_user: has_user,
    );
  }
}