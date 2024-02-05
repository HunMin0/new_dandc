import 'dart:ffi';

import 'package:Deal_Connect/model/user.dart';

class Partner {
  final int id;
  final int user_id;
  final int partner_user_id;
  final Bool is_approved;
  final String? approved_at;
  final User? has_partner;
  final DateTime? created_at;
  final DateTime? updated_at;


  Partner({
    required this.id,
    required this.user_id,
    required this.partner_user_id,
    required this.is_approved,
    required this.created_at,
    required this.updated_at,
    this.approved_at,
    this.has_partner,
  });

  factory Partner.fromJSON(Map<String, dynamic> json) {
    var has_partner = json['partner_user_id'] != null ? User.fromJSON(json['has_partner']) : null;

    return Partner(
        id: json['id'],
        user_id: json['user_id'],
        partner_user_id: json['partner_user_id'],
        is_approved: json['is_approved'],
        approved_at: json['approved_at'],
        created_at: json['created_at'],
        updated_at: json['updated_at'],
        has_partner: has_partner
    );
  }
}