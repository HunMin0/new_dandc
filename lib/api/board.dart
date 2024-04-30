import 'dart:convert';
import 'dart:io';
import 'package:Deal_Connect/Utils/shared_pref_utils.dart';
import 'package:Deal_Connect/api/server_config.dart';
import 'package:Deal_Connect/model/response_data.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';


Future<ResponseData> getBoardWrites({Map? queryMap}) async {
  var url = ServerConfig.SERVER_API_URL + 'app/board_write';
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
  // print(jsonBody.toString());
  return ResponseData.fromJSON(jsonBody, response.statusCode);
}

Future<ResponseData> storeGroupBoardWrite(
    Map mapData,
    File? imageFile,
  ) async {
  var url = ServerConfig.SERVER_API_URL + 'app/group_board';
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

  // if (fileList.isNotEmpty) {
  //   for (var element in fileList) {
  //     http.MultipartFile multipartFile = http.MultipartFile.fromBytes(
  //       'files[]',
  //       element.resizedImage,
  //       filename: element.resizedImageName,
  //       contentType: MediaType.parse('image/jpeg'),
  //     );
  //     request.files.add(multipartFile);
  //   }
  // }
  String? token = await SharedPrefUtils.getAccessToken();
  request.headers
      .addAll({"Content-Type": "application/json", "Authorization": token!});

  http.StreamedResponse response = await request.send();
  final res = await http.Response.fromStream(response);
  // print(utf8.decode(res.bodyBytes));
  var jsonBody = json.decode(utf8.decode(res.bodyBytes));
  return ResponseData.fromJSON(jsonBody, response.statusCode);
}

Future<ResponseData> updateGroupBoardWrite(
    int boardWriteId, Map mapData, File? imageFile) async {
  var url = ServerConfig.SERVER_API_URL + 'app/group_board/$boardWriteId';
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
  print(token);
  request.headers
      .addAll({"Content-Type": "application/json", "Authorization": token!});

  http.StreamedResponse response = await request.send();
  print(response.statusCode);

  final res = await http.Response.fromStream(response);
  print(utf8.decode(res.bodyBytes));
  var jsonBody = json.decode(utf8.decode(res.bodyBytes));
  return ResponseData.fromJSON(jsonBody, response.statusCode);
}

Future<ResponseData> updateBoardWriteHits(int boardWriteId) async {
  var url = ServerConfig.SERVER_API_URL + 'app/group_board/hits/$boardWriteId';
  var postUri = Uri.parse(url);
  http.MultipartRequest request = http.MultipartRequest("POST", postUri);

  String? token = await SharedPrefUtils.getAccessToken();
  request.headers
      .addAll({"Content-Type": "application/json", "Authorization": token!});

  http.StreamedResponse response = await request.send();
  final res = await http.Response.fromStream(response);
  var jsonBody = json.decode(utf8.decode(res.bodyBytes));
  return ResponseData.fromJSON(jsonBody, response.statusCode);
}

Future<ResponseData> getBoardWriteLatestData(int groupId) async {
  var url = ServerConfig.SERVER_API_URL + 'app/group_board/latest/$groupId';
  String? token = await SharedPrefUtils.getAccessToken();
  http.Response response = await http.get(
    Uri.parse(url),
    headers: {"Content-Type": "application/json", "Authorization": token!},
  );
  print(utf8.decode(response.bodyBytes));
  var jsonBody = json.decode(utf8.decode(response.bodyBytes));
  return ResponseData.fromJSON(jsonBody, response.statusCode);
}



Future<ResponseData> getBoardWrite(int id) async {
  var url = ServerConfig.SERVER_API_URL + 'app/group_board/$id';
  String? token = await SharedPrefUtils.getAccessToken();
  http.Response response = await http.get(
    Uri.parse(url),
    headers: {"Content-Type": "application/json", "Authorization": token!},
  );
  var jsonBody = json.decode(utf8.decode(response.bodyBytes));
  // print(jsonBody.toString());
  return ResponseData.fromJSON(jsonBody, response.statusCode);
}


Future<ResponseData> deleteBoardWrite(int id) async {
  var url = ServerConfig.SERVER_API_URL + 'app/group_board/$id';
  print(url);
  String? token = await SharedPrefUtils.getAccessToken();
  http.Response response = await http.delete(Uri.parse(url),
    headers: {
      "Content-Type": "application/json",
      "Authorization": token!
    },
  );
  var jsonBody = json.decode(utf8.decode(response.bodyBytes));
  return ResponseData.fromJSON(jsonBody, response.statusCode);
}

