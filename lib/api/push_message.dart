import 'dart:convert';
import 'package:Deal_Connect/Utils/shared_pref_utils.dart';
import 'package:Deal_Connect/api/server_config.dart';
import 'package:Deal_Connect/model/response_data.dart';
import 'package:http/http.dart' as http;

Future<ResponseData> getPushMessages({Map? queryMap}) async {
  var url = ServerConfig.SERVER_API_URL + 'app/push_message';
  String? token = await SharedPrefUtils.getAccessToken();
  var query = '';
  if (queryMap != null) {
    queryMap.forEach(((key, value) {
      if (value != null) {
        if (query.isNotEmpty) {
          query += '&';
        }
        query += '$key=$value';
      }
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
