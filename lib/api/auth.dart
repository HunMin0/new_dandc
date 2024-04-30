import 'dart:convert';
import 'dart:io';
import 'package:Deal_Connect/Utils/custom_dialog.dart';
import 'package:Deal_Connect/Utils/shared_pref_utils.dart';
import 'package:Deal_Connect/api/server_config.dart';
import 'package:Deal_Connect/model/response_data.dart';
import 'package:Deal_Connect/model/user.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  print(response.body);
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
  // print(response.body);
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

Future<ResponseData> postSnsRegister(Map mapData) async {
  var url = ServerConfig.SERVER_API_URL + 'auth/sns_register';
  var body = json.encode(mapData);
  http.Response response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: body
  );
  var jsonBody = json.decode(utf8.decode(response.bodyBytes));
  print(jsonBody.toString());
  return ResponseData.fromJSON(jsonBody, response.statusCode);
}

Future<ResponseData> postCheckId(Map mapData) async {
  var url = ServerConfig.SERVER_API_URL + 'auth/checkId';
  var body = json.encode(mapData);
  http.Response response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: body
  );
  var jsonBody = json.decode(utf8.decode(response.bodyBytes));
  return ResponseData.fromJSON(jsonBody, response.statusCode);
}

Future<ResponseData> postCheckRecommendCode(Map mapData) async {
  var url = ServerConfig.SERVER_API_URL + 'auth/checkCode';
  var body = json.encode(mapData);
  http.Response response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: body
  );
  var jsonBody = json.decode(utf8.decode(response.bodyBytes));
  return ResponseData.fromJSON(jsonBody, response.statusCode);
}

Future<ResponseData> getMyPageData() async {
  var url = ServerConfig.SERVER_API_URL + 'app/user/my_page_data';
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
//
// Future<ResponseData> updateUser(int userId, Map mapData) async {
//   var url = ServerConfig.SERVER_API_URL + 'user/$userId';
//   var body = json.encode(mapData);
//   String? token = await SharedPrefUtils.getAccessToken();
//   http.Response response = await http.post(Uri.parse(url),
//     headers: {
//       "Content-Type": "application/json",
//       "Authorization": token!,
//     },
//     body: body,
//   );
//   var jsonBody = json.decode(utf8.decode(response.bodyBytes));
//   return ResponseData.fromJSON(jsonBody, response.statusCode);
// }


Future<ResponseData> updateAgreement(Map mapData) async {
  var url = ServerConfig.SERVER_API_URL + 'app/agreement';
  var body = json.encode(mapData);
  print(body.toString());
  String? token = await SharedPrefUtils.getAccessToken();
  http.Response response = await http.post(Uri.parse(url),
    headers: {
      "Content-Type": "application/json",
      "Authorization": token!,
    },
    body: body,
  );
  var jsonBody = json.decode(utf8.decode(response.bodyBytes));
  print(jsonBody.toString());
  return ResponseData.fromJSON(jsonBody, response.statusCode);
}


Future<ResponseData> updateProfile(Map mapData, File? imageFile) async {
  var url = ServerConfig.SERVER_API_URL + 'app/user/update';
  var postUri = Uri.parse(url);
  http.MultipartRequest request = http.MultipartRequest("POST", postUri);

  if (mapData.isNotEmpty) {
    mapData.forEach((key, value) {
      request.fields[key] = value.toString();
    });
  }

  if (imageFile != null) {
    request.files.add(http.MultipartFile.fromBytes(
      'imageFile',
      Utils.encodeResizedImage(imageFile.path),
      filename: basename(imageFile.path),
      contentType: MediaType.parse('image/jpeg'),
    ));
  }

  String? token = await SharedPrefUtils.getAccessToken();
  request.headers
      .addAll({"Content-Type": "application/json", "Authorization": token!});

  http.StreamedResponse response = await request.send();
  // print(response.statusCode);

  final res = await http.Response.fromStream(response);
  // print(utf8.decode(res.bodyBytes));
  var jsonBody = json.decode(utf8.decode(res.bodyBytes));
  return ResponseData.fromJSON(jsonBody, response.statusCode);
}

Future<ResponseData> updateFcmToken(Map mapData) async {
  var url = ServerConfig.SERVER_API_URL + 'app/fcm_token';
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

Future<bool> refreshFcmToken() async {

  String? token;

  if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.macOS) {
    print('FlutterFire Messaging Example: Getting APNs token...');
    token = await FirebaseMessaging.instance.getAPNSToken();
    print('FlutterFire Messaging Example: Got APNs token: $token');
  } else {
    token = await FirebaseMessaging.instance
        .getToken(
        vapidKey: 'BA1nj53YVUK7e3AtouYjGoyMNK4BBn0Pofo_YZhK6CBXIhzlj2KpvFITzLjyXT8nvpupZ4lxQudQUz9b0it_Tl4');
  }


  print('fcm token: $token');

  User? myUser = await SharedPrefUtils.getUser();

  ResponseData responseData;
  if (myUser != null) {
    responseData = await updateFcmToken({
      'token': token,
      'user_id': myUser.id,
    });
  } else {
    responseData = await updateFcmToken({
      'token': token,
    });
  }

  if (responseData.status == 'success') {
    print(responseData.data);
    print('token update success');
  } else {
    print('token update failed');
    print('message: ${responseData.message}');
  }

  return true;
}

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
  var url = ServerConfig.SERVER_API_URL + 'app/auth/destroy';
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


Future<ResponseData> userDestroyBack(Map mapData) async {
  String? token = await SharedPrefUtils.getAccessToken();
  User? user = await SharedPrefUtils.getUser();
  var url = ServerConfig.SERVER_API_URL + 'app/auth/destroy/back';
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

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('mainData');
    var jsonBody = json.decode(utf8.decode(response.bodyBytes));
    return ResponseData.fromJSON(jsonBody, response.statusCode);
  } catch (e) {
    print(e);
    return ResponseData(statusCode: 427);
  }
}

Future<ResponseData> getMyUser() async {
  String? token = await SharedPrefUtils.getAccessToken();
  var url = ServerConfig.SERVER_API_URL + 'user_app';
  http.Response response = await http.get(Uri.parse(url),
    headers: {
      "Content-Type": "application/json",
      "Authorization": token!
    },
  );
  var jsonBody = json.decode(utf8.decode(response.bodyBytes));
  // print(jsonBody.toString());
  return ResponseData.fromJSON(jsonBody, response.statusCode);
}

// Future<ResponseData> sendVerifyMail(Map mapData) async {
//   var url = ServerConfig.SERVER_API_URL + 'verify';
//   var body = json.encode(mapData);
//   http.Response response = await http.post(Uri.parse(url),
//       headers: {"Content-Type": "application/json"},
//       body: body
//   );
//   var jsonBody = json.decode(utf8.decode(response.bodyBytes));
//   return ResponseData.fromJSON(jsonBody, response.statusCode);
// }
//
// Future<ResponseData> checkVerifyMail(Map mapData) async {
//   var url = ServerConfig.SERVER_API_URL + 'verify/check';
//   var body = json.encode(mapData);
//   http.Response response = await http.post(Uri.parse(url),
//       headers: {"Content-Type": "application/json"},
//       body: body
//   );
//   var jsonBody = json.decode(utf8.decode(response.bodyBytes));
//   return ResponseData.fromJSON(jsonBody, response.statusCode);
// }


Future<ResponseData> sendPasswordMail(Map mapData) async {
  var url = ServerConfig.SERVER_API_URL + 'auth/find';
  print(url);
  var body = json.encode(mapData);
  http.Response response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: body
  );
  var jsonBody = json.decode(utf8.decode(response.bodyBytes));
  print(response.bodyBytes.toString());
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