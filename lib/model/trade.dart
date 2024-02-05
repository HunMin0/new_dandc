import 'dart:ffi';
import 'package:Deal_Connect/model/file.dart';
import 'package:Deal_Connect/model/user.dart';
import 'package:Deal_Connect/model/user_business.dart';

class Trade {
  final int id;
  final int user_id;
  final int partner_user_id;
  final int user_business_id;
  final Bool is_approved;
  final String trade_type; // B: 구매, S: 판매
  final int price;
  final String trade_services;

  final int? receipt_file_id;
  final String? user_description;
  final String? partner_user_description;
  final String? partner_return_reason;
  final File? has_receipt_image;
  final User? has_partner;
  final UserBusiness? has_partner_business;

  final DateTime? traded_at;
  final DateTime? created_at;
  final DateTime? updated_at;
  final DateTime? processed_at;

  Trade({
    required this.id,
    required this.user_id,
    required this.partner_user_id,
    required this.user_business_id,
    required this.is_approved,
    required this.trade_type,
    required this.price,
    required this.trade_services,
    this.has_partner,
    this.has_partner_business,

    this.receipt_file_id,
    this.user_description,
    this.partner_user_description,
    this.partner_return_reason,
    this.has_receipt_image,

    this.traded_at,
    this.created_at,
    this.updated_at,
    this.processed_at,
  });

  factory Trade.fromJSON(Map<String, dynamic> json) {
    var has_receipt_image = json['receipt_file_id'] != null ? File.fromJSON(json['has_receipt_image']) : null;
    var has_partner = json['partner_user_id'] != null ? User.fromJSON(json['has_partner']) : null;
    var has_partner_business = json['user_business_id'] != null ? UserBusiness.fromJSON(json['has_partner_business']) : null;

    return Trade(
        id: json['id'],
        user_id: json['user_id'],
        partner_user_id: json['partner_user_id'],
        user_business_id: json['user_business_id'],
        is_approved: json['is_approved'],
        trade_type: json['trade_type'],
        price: json['price'],
        trade_services: json['trade_services'],
        receipt_file_id: json['receipt_file_id'],
        user_description: json['user_description'],
        partner_user_description: json['partner_user_description'],
        partner_return_reason: json['partner_return_reason'],
        traded_at: json['traded_at'],
        created_at: json['created_at'],
        updated_at: json['updated_at'],
        processed_at: json['processed_at'],
        has_partner: has_partner,
        has_partner_business: has_partner_business,
        has_receipt_image: has_receipt_image,
    );
  }
}