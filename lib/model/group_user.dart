import 'package:Deal_Connect/model/group.dart';
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
  final String? approved_at;
  final User? has_user;
  final Group? has_group;

  GroupUser({
    required this.id,
    required this.group_id,
    required this.user_id,
    required this.is_leader,
    this.total_trade_amount,
    this.is_approved,
    this.is_deleted,
    this.return_reason,
    this.approved_at,
    this.has_user,
    this.has_group,
  });

  factory GroupUser.fromJSON(Map<String, dynamic> json) {
    var has_user = json['has_user'] != null ? User.fromJSON(json['has_user']) : null;
    var has_group = json['has_group'] != null ? Group.fromJSON(json['has_group']) : null;


    return GroupUser(
      id: json['id'],
      group_id: json['group_id'],
      user_id: json['user_id'],
      is_leader: json['is_leader'],
      is_approved: json['is_approved'],
      is_deleted: json['is_deleted'],
      return_reason: json['return_reason'],
      total_trade_amount: json['total_trade_amount'],
      approved_at: json['approved_at'],
      has_user: has_user,
      has_group: has_group,
    );
  }
}