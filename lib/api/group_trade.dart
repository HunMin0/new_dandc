import 'dart:convert';
import 'dart:io';
import 'package:Deal_Connect/Utils/shared_pref_utils.dart';
import 'package:Deal_Connect/api/server_config.dart';
import 'package:Deal_Connect/model/response_data.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';


Future<ResponseData> getGroupTrades({Map? queryMap}) async {
  var url = ServerConfig.SERVER_API_URL + 'app/group_trade';
  String? token = await SharedPrefUtils.getAccessToken();
  var query = '';
  if (queryMap != null) {
    queryMap.forEach(((key, value) {
      if (query.isNotEmpty && query != null) {
        query += '&';
      }
      query += '$key=$value';
    }));
    if (query.isNotEmpty && query != null) {
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
  print(url.toString());
  return ResponseData.fromJSON(jsonBody, response.statusCode);
}