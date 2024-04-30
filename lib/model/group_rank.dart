import 'package:Deal_Connect/model/user.dart';

class GroupRank {
  final int user_id;
  final int total_trade_amount;
  final User? has_user;

  GroupRank({
    required this.user_id,
    this.has_user,
    required this.total_trade_amount,
  });

  factory GroupRank.fromJSON(Map<String, dynamic> json) {
    var has_user = json['has_user'] != null ? User.fromJSON(json['has_user']) : null;

    return GroupRank(
      user_id: json['user_id'],
      total_trade_amount: int.parse(json['total_trade_amount']),
      has_user: has_user,
    );
  }
}