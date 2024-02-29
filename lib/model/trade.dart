import 'dart:ffi';
import 'package:Deal_Connect/model/file.dart';
import 'package:Deal_Connect/model/user.dart';
import 'package:Deal_Connect/model/user_business.dart';

class Trade {
  final int id;
  final int request_user_id;
  final int response_user_id;
  final int buy_user_id;
  final int business_owner_id;


  final int user_business_id;
  final String? trade_status; // pending: 승인대기, approved: 승인, rejected: 거절
  final String trade_type; // B: 구매, S: 판매
  final int price;
  final String trade_services;

  final int? receipt_file_id;
  final String? user_description;
  final String? business_user_description;
  final String? partner_return_reason;
  final File? has_receipt_image;
  final User? has_buy_user;
  final User? has_business_owner;
  final User? has_request_user;
  final UserBusiness? has_business;

  final String? traded_at;
  final String created_at;
  final String updated_at;
  final String? processed_at;

  Trade({
    required this.id,
    required this.request_user_id,
    required this.response_user_id,
    required this.buy_user_id,
    required this.business_owner_id,

    required this.user_business_id,

    this.trade_status,
    required this.trade_type,
    required this.price,
    required this.trade_services,
    this.has_buy_user,
    this.has_request_user,
    this.has_business_owner,
    this.has_business,
    this.receipt_file_id,
    this.user_description,
    this.business_user_description,
    this.partner_return_reason,
    this.has_receipt_image,
    this.traded_at,
    required this.created_at,
    required this.updated_at,
    this.processed_at,
  });

  factory Trade.fromJSON(Map<String, dynamic> json) {
    var has_receipt_image = json['has_receipt_image'] != null
        ? File.fromJSON(json['has_receipt_image'])
        : null;
    var has_buy_user = json['has_buy_user'] != null
        ? User.fromJSON(json['has_buy_user'])
        : null;
    var has_business = json['has_business'] != null
        ? UserBusiness.fromJSON(json['has_business'])
        : null;
    var has_business_owner = json['has_business_owner'] != null
        ? User.fromJSON(json['has_business_owner'])
        : null;

    var has_request_user = json['has_request_user'] != null
        ? User.fromJSON(json['has_request_user'])
        : null;

    return Trade(
      id: json['id'],
      request_user_id: json['request_user_id'],
      response_user_id: json['response_user_id'],
      buy_user_id: json['buy_user_id'],
      business_owner_id: json['business_owner_id'],
      user_business_id: json['user_business_id'],
      trade_status: json['trade_status'],
      trade_type: json['trade_type'],
      price: json['price'],
      trade_services: json['trade_services'],
      receipt_file_id: json['receipt_file_id'],
      user_description: json['user_description'],
      business_user_description: json['business_user_description'],
      partner_return_reason: json['partner_return_reason'],
      traded_at: json['traded_at'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      processed_at: json['processed_at'],
      has_business_owner: has_business_owner,
      has_buy_user: has_buy_user,
      has_business: has_business,
      has_request_user: has_request_user,
      has_receipt_image: has_receipt_image,
    );
  }
}
