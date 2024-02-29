import 'dart:ffi';

import 'package:Deal_Connect/model/user.dart';

class Partner {
  final int id;
  final int user_id;
  final int partner_user_id;
  final int? total_trade_amount;
  final bool? is_approved;
  final String? approved_at;
  final User? has_user;
  final String? created_at;
  final String? updated_at;


  Partner({
    required this.id,
    required this.user_id,
    required this.partner_user_id,
    this.is_approved,
    this.total_trade_amount,
    required this.created_at,
    required this.updated_at,
    this.approved_at,
    this.has_user,
  });

  factory Partner.fromJSON(Map<String, dynamic> json) {
    var has_user = json['has_user'] != null ? User.fromJSON(json['has_user']) : null;

    return Partner(
        id: json['id'],
        user_id: json['user_id'],
        partner_user_id: json['partner_user_id'],
        total_trade_amount: json['total_trade_amount'],
        is_approved: json['is_approved'],
        approved_at: json['approved_at'],
        created_at: json['created_at'],
        updated_at: json['updated_at'],
        has_user: has_user
    );
  }
}