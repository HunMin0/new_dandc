import 'dart:convert';

import 'package:Deal_Connect/utils/context_extension.dart';
import 'package:Deal_Connect/utils/shared_pref_utils.dart';
import 'package:Deal_Connect/api/server_config.dart';
import 'package:Deal_Connect/model/response_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

Future<ResponseData> getMainData(BuildContext context, {Map? queryMap}) async {
  var url = ServerConfig.SERVER_API_URL + 'app/main';
  String? token = await SharedPrefUtils.getAccessToken();
  var query = '';
  if (queryMap != null) {
    queryMap.forEach(((key, value) {
      if (query.isNotEmpty) {
        query += '&';
      }
      query += '$key=$value';
    }));
    if (query.isNotEmpty) {
      url += '?$query';
    }
  }
  http.Response response = await http.get(Uri.parse(url),
    headers: {
      "Content-Type": "application/json",
      "Authorization": token!
    },
  );

  if (response.statusCode == 401) {
    context.logoutAndRedirectToIntro();
  }

  var jsonBody = json.decode(utf8.decode(response.bodyBytes));
  // print(jsonBody.toString());
  return ResponseData.fromJSON(jsonBody, response.statusCode);
}