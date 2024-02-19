import 'dart:convert';
import 'dart:io';
import 'package:Deal_Connect/Utils/shared_pref_utils.dart';
import 'package:Deal_Connect/api/server_config.dart';
import 'package:Deal_Connect/model/response_data.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

Future<ResponseData> storeGroupUser(Map mapData) async {
  var url = ServerConfig.SERVER_API_URL + 'app/group_user/create';
  var body = json.encode(mapData);
  String? token = await SharedPrefUtils.getAccessToken();
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

Future<ResponseData> manageGroupUser(Map mapData) async {
  var url = ServerConfig.SERVER_API_URL + 'app/group_user/manage';
  var body = json.encode(mapData);
  String? token = await SharedPrefUtils.getAccessToken();
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

Future<ResponseData> getGroupUsers({Map? queryMap}) async {
  var url = ServerConfig.SERVER_API_URL + 'app/group_user';
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
  var jsonBody = json.decode(utf8.decode(response.bodyBytes));
  // print(jsonBody.toString());
  return ResponseData.fromJSON(jsonBody, response.statusCode);
}

Future<ResponseData> getGroupUser({Map? queryMap}) async {
  var url = ServerConfig.SERVER_API_URL + 'app/group_user/mine';
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
  var jsonBody = json.decode(utf8.decode(response.bodyBytes));
  print(jsonBody.toString());
  return ResponseData.fromJSON(jsonBody, response.statusCode);
}
