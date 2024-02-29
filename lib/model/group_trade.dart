import 'package:Deal_Connect/model/trade.dart';
import 'package:Deal_Connect/model/user.dart';
import 'package:Deal_Connect/model/user_business.dart';

class GroupTrade {
  final int id;
  final int group_id;
  final int trade_id;
  final int user_id;
  final int business_owner_id;
  final int user_business_id;
  final int? total_trade_amount;
  final int? price;
  final String? trade_type;
  final User? has_user;
  final UserBusiness? has_business;
  final User? has_business_owner;
  final Trade? has_trade;

  GroupTrade({
    required this.id,
    required this.group_id,
    required this.trade_id,
    required this.user_id,
    required this.business_owner_id,
    required this.user_business_id,
    this.total_trade_amount,
    this.price,
    this.trade_type,
    this.has_user,
    this.has_business,
    this.has_business_owner,
    this.has_trade,
  });

  factory GroupTrade.fromJSON(Map<String, dynamic> json) {
    var has_user = json['has_user'] != null ? User.fromJSON(json['has_user']) : null;
    var has_business = json['has_business'] != null ? UserBusiness.fromJSON(json['has_business']) : null;
    var has_business_owner = json['has_business_owner'] != null ? User.fromJSON(json['has_business_owner']) : null;
    var has_trade = json['has_trade'] != null ? Trade.fromJSON(json['has_trade']) : null;


    return GroupTrade(
      id: json['id'],
      group_id: json['group_id'],
      trade_id: json['trade_id'],
      user_id: json['user_id'],
      business_owner_id: json['business_owner_id'],
      user_business_id: json['user_business_id'],
      total_trade_amount: json['total_trade_amount'],
      price: json['price'],
      trade_type: json['trade_type'],
      has_user: has_user,
      has_business_owner: has_business_owner,
      has_business: has_business,
      has_trade: has_trade,
    );
  }
}