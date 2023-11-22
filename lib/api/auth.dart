import 'dart:convert';
import 'package:DealConnect/Utils/custom_dialog.dart';
import 'package:DealConnect/Utils/shared_pref_utils.dart';
import 'package:DealConnect/api/server_config.dart';
import 'package:DealConnect/model/response_data.dart';
import 'package:DealConnect/model/user.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

/*
Login API
 */
Future<ResponseData> postLogin(Map mapData) async {
  var url = ServerConfig.SERVER_API_URL + 'auth/login';
  var body = json.encode(mapData);
  http.Response response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: body
  );
  var jsonBody = json.decode(utf8.decode(response.bodyBytes));
  return ResponseData.fromJSON(jsonBody, response.statusCode);
}

Future<ResponseData> postSnsLogin(Map mapData) async {
  var url = ServerConfig.SERVER_API_URL + 'auth/sns/login/social';
  var body = json.encode(mapData);
  http.Response response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: body
  );
  print(response.body);
  var jsonBody = json.decode(utf8.decode(response.bodyBytes));
  return ResponseData.fromJSON(jsonBody, response.statusCode);
}

/*
Register API
 */
Future<ResponseData> postRegister(Map mapData) async {
  var url = ServerConfig.SERVER_API_URL + 'auth/register';
  var body = json.encode(mapData);
  http.Response response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: body
  );
  var jsonBody = json.decode(utf8.decode(response.bodyBytes));
  return ResponseData.fromJSON(jsonBody, response.statusCode);
}

Future<ResponseData> getMyPageData() async {
  var url = ServerConfig.SERVER_API_URL + 'user/my_page_data';
  String? token = await SharedPrefUtils.getAccessToken();
  http.Response response = await http.get(Uri.parse(url),
    headers: {
      "Content-Type": "application/json",
      "Authorization": token!,
    },
  );
  var jsonBody = json.decode(utf8.decode(response.bodyBytes));
  return ResponseData.fromJSON(jsonBody, response.statusCode);
}

Future<ResponseData> updateUser(int userId, Map mapData) async {
  var url = ServerConfig.SERVER_API_URL + 'user/$userId';
  var body = json.encode(mapData);
  String? token = await SharedPrefUtils.getAccessToken();
  http.Response response = await http.post(Uri.parse(url),
    headers: {
      "Content-Type": "application/json",
      "Authorization": token!,
    },
    body: body,
  );
  var jsonBody = json.decode(utf8.decode(response.bodyBytes));
  return ResponseData.fromJSON(jsonBody, response.statusCode);
}
//
// Future<ResponseData> updateFcmToken(Map mapData) async {
//   var url = ServerConfig.SERVER_API_URL + 'fcm_token';
//   var body = json.encode(mapData);
//   // String? token = await SharedPrefUtils.getAccessToken();
//   http.Response response = await http.post(Uri.parse(url),
//     headers: {
//       "Content-Type": "application/json",
//       // "Authorization": token!,
//     },
//     body: body,
//   );
//   var jsonBody = json.decode(utf8.decode(response.bodyBytes));
//   return ResponseData.fromJSON(jsonBody, response.statusCode);
// }
//
// Future<bool> refreshFcmToken() async {
//   // String? token = await FirebaseMessaging.instance
//   //     .getToken(
//   //     vapidKey: 'BE5qrDhfiSkOYxn1V0DZdxrFO8QVU15Ct5vfg4U9ccP1vHQ60yd6JonEq6mom56evzbrv_nlpRGcyuvJmIQTiSM');
//   //
//   // print('fcm token: $token');
//
//   User? myUser = await SharedPrefUtils.getUser();
//
//   ResponseData responseData;
//   if (myUser != null) {
//     responseData = await updateFcmToken({
//       'token': token,
//       'user_id': myUser.id,
//     });
//   } else {
//     responseData = await updateFcmToken({
//       'token': token,
//     });
//   }
//
//   if (responseData.status == 'success') {
//     print(responseData.data);
//     print('token update success');
//   } else {
//     print('token update failed');
//     print('message: ${responseData.message}');
//   }
//
//   return true;
// }

Future<bool> initLoginUserData(User user, String tokenType, String accessToken) async {
  print('initLoginUserData');

  await SharedPrefUtils.setAccessToken(tokenType, accessToken);
  await SharedPrefUtils.setUser(user);
  bool result = true;

  return result;
}

Future<ResponseData> userDestroy(Map mapData) async {
  String? token = await SharedPrefUtils.getAccessToken();
  User? user = await SharedPrefUtils.getUser();
  var url = ServerConfig.SERVER_API_URL + 'auth/check_password_destroy/${user!.id}';
  var body = json.encode(mapData);
  http.Response response = await http.post(Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": token!
      },
      body: body
  );
  print(utf8.decode(response.bodyBytes));
  var jsonBody = json.decode(utf8.decode(response.bodyBytes));
  return ResponseData.fromJSON(jsonBody, response.statusCode);
}

Future<ResponseData> logout(Map mapData) async {
  String? token = await SharedPrefUtils.getAccessToken();
  var url = ServerConfig.SERVER_API_URL + 'auth/logout';
  var body = json.encode(mapData);
  http.Response response = await http.post(Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": token!
      },
      body: body
  );
  try {
    var jsonBody = json.decode(utf8.decode(response.bodyBytes));
    return ResponseData.fromJSON(jsonBody, response.statusCode);
  } catch (e) {
    print(e);
    return ResponseData(statusCode: 427);
  }
}

Future<ResponseData> getMyUser() async {
  User? user = await SharedPrefUtils.getUser();
  var url = ServerConfig.SERVER_API_URL + 'user/${user?.id}';
  http.Response response = await http.get(Uri.parse(url),
    headers: {"Content-Type": "application/json"},
  );
  var jsonBody = json.decode(utf8.decode(response.bodyBytes));
  return ResponseData.fromJSON(jsonBody, response.statusCode);
}

Future<ResponseData> sendVerifyMail(Map mapData) async {
  var url = ServerConfig.SERVER_API_URL + 'verify';
  var body = json.encode(mapData);
  http.Response response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: body
  );
  var jsonBody = json.decode(utf8.decode(response.bodyBytes));
  return ResponseData.fromJSON(jsonBody, response.statusCode);
}

Future<ResponseData> checkVerifyMail(Map mapData) async {
  var url = ServerConfig.SERVER_API_URL + 'verify/check';
  var body = json.encode(mapData);
  http.Response response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: body
  );
  var jsonBody = json.decode(utf8.decode(response.bodyBytes));
  return ResponseData.fromJSON(jsonBody, response.statusCode);
}

Future<ResponseData> changePassword(Map mapData) async {
  var url = ServerConfig.SERVER_API_URL + 'auth/password/change';
  var body = json.encode(mapData);
  http.Response response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: body
  );
  var jsonBody = json.decode(utf8.decode(response.bodyBytes));
  return ResponseData.fromJSON(jsonBody, response.statusCode);
}

Future<bool> checkLoginModal(BuildContext context) async {
  bool isLogin = false;

  var user = await SharedPrefUtils.getUser();
  isLogin = user != null;

  if (!isLogin) {
    CustomDialog.showLoginDialog(context: context, onLoginBtnClick: () {
      Future.delayed(const Duration(milliseconds: 100), () {
        Navigator.pushNamed(context, '/login');
        // Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      });
    });
  }

  return isLogin;
}