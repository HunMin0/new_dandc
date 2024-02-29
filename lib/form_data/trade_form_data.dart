import 'dart:io';

class TradeFormData {
  String? tradedAt;
  String? tradeServices;
  String? price;
  String? userDescription;
  String? businessUserDescription;
  File? receiptFile;
  int? userId;
  int? userBusinessId;
  String? tradeType;

  TradeFormData({
    this.tradedAt,
    this.tradeServices,
    this.price,
    this.userDescription,
    this.businessUserDescription,
    this.tradeType,
    this.userId,
    this.userBusinessId,
    this.receiptFile,
  });

  Map<String, dynamic> toMap() {
    return {
      'traded_at': tradedAt.toString() ?? '',
      'trade_services': tradeServices ?? '',
      'price': price ?? '',
      'user_description': userDescription ?? '',
      'business_user_description': businessUserDescription ?? '',
      'user_id': userId ?? '',
      'user_business_id': userBusinessId ?? '',
      'trade_type': tradeType ?? '',
    };
  }
}
