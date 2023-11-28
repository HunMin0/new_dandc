import 'package:Deal_Connect/model/user.dart';

class LoginResponseData {
  final String tokenType;
  final String accessToken;
  final User user;

  LoginResponseData({required this.tokenType, required this.accessToken, required this.user});

  factory LoginResponseData.fromJSON(Map<String, dynamic> json) {
    return LoginResponseData(
      tokenType: json['token_type'],
      accessToken: json['access_token'],
      user: User.fromJSON(json['user']),
    );
  }
}