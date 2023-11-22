import 'dart:convert';
import 'package:DealConnect/api/server_config.dart';
import 'package:DealConnect/model/response_data.dart';
import 'package:http/http.dart' as http;

Future<ResponseData> getTermsCategories() async {
  var url = ServerConfig.SERVER_API_URL + 'terms_category';
  http.Response response = await http.get(Uri.parse(url),
    headers: {"Content-Type": "application/json"},
  );
  var jsonBody = json.decode(utf8.decode(response.bodyBytes));
  return ResponseData.fromJSON(jsonBody, response.statusCode);
}

Future<ResponseData> getTerms(categoryId) async {
  var url = ServerConfig.SERVER_API_URL + 'terms';
  url += '?category_id=' + categoryId.toString();
  http.Response response = await http.get(Uri.parse(url),
    headers: {"Content-Type": "application/json"},
  );
  var jsonBody = json.decode(utf8.decode(response.bodyBytes));
  return ResponseData.fromJSON(jsonBody, response.statusCode);
}

Future<ResponseData> getCompanySetting() async {
  var url = ServerConfig.SERVER_API_URL + 'company_setting';
  http.Response response = await http.get(Uri.parse(url),
    headers: {"Content-Type": "application/json"},
  );
  var jsonBody = json.decode(utf8.decode(response.bodyBytes));
  return ResponseData.fromJSON(jsonBody, response.statusCode);
}

Future<ResponseData> getAppConfig() async {
  var url = ServerConfig.SERVER_API_URL + 'app_config';
  http.Response response = await http.get(Uri.parse(url),
    headers: {"Content-Type": "application/json"},
  );
  var jsonBody = json.decode(utf8.decode(response.bodyBytes));
  return ResponseData.fromJSON(jsonBody, response.statusCode);
}