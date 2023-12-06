import 'dart:convert';
import 'package:Deal_Connect/Utils/custom_dialog.dart';
import 'package:Deal_Connect/Utils/shared_pref_utils.dart';
import 'package:Deal_Connect/api/server_config.dart';
import 'package:Deal_Connect/model/response_data.dart';
import 'package:Deal_Connect/model/user.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;


Future<ResponseData> postRegisterGroup(Map mapData) async {
  String? token = await SharedPrefUtils.getAccessToken();
  var url = ServerConfig.SERVER_API_URL + 'group';
  var body = json.encode(mapData);
  http.Response response = await http.post(Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": token!
      },
      body: body
  );
  var jsonBody = json.decode(utf8.decode(response.bodyBytes));
  return ResponseData.fromJSON(jsonBody, response.statusCode);
}