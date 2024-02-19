import 'dart:convert';
import 'dart:io';
import 'package:Deal_Connect/Utils/shared_pref_utils.dart';
import 'package:Deal_Connect/api/server_config.dart';
import 'package:Deal_Connect/model/response_data.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';


Future<ResponseData> getGroups({Map? queryMap}) async {
  var url = ServerConfig.SERVER_API_URL + 'app/group';
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

Future<ResponseData> getGroup(int id) async {
  var url = ServerConfig.SERVER_API_URL + 'app/group/$id';
  String? token = await SharedPrefUtils.getAccessToken();
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

Future<ResponseData> storeGroup(Map mapData, File? imageFile) async {
  var url = ServerConfig.SERVER_API_URL + 'app/group/create';
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