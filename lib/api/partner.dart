import 'dart:convert';
import 'package:Deal_Connect/Utils/shared_pref_utils.dart';
import 'package:Deal_Connect/api/server_config.dart';
import 'package:Deal_Connect/model/response_data.dart';
import 'package:http/http.dart' as http;


Future<ResponseData> getPartnerUser(int id) async {
  var url = ServerConfig.SERVER_API_URL + 'app/profile/$id';
  String? token = await SharedPrefUtils.getAccessToken();
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

//나와 파트너인지, 파트너 수는 몇명인지 조회
Future<ResponseData> getPartnerProfileData(int id) async {
  var url = ServerConfig.SERVER_API_URL + 'app/partner/profile/$id';
  print(url.toString());
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



Future<ResponseData> getPartners({Map? queryMap}) async {
  var url = ServerConfig.SERVER_API_URL + 'app/partner';
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
  return ResponseData.fromJSON(jsonBody, response.statusCode);
}

Future<ResponseData> attendPartner(Map mapData) async {
  var url = ServerConfig.SERVER_API_URL + 'app/partner/create';
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

Future<ResponseData> approvePartner(Map mapData) async {
  var url = ServerConfig.SERVER_API_URL + 'app/partner/approve';
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


//나와 파트너인지, 파트너 수는 몇명인지 조회
Future<ResponseData> getPartnership(int id) async {
  var url = ServerConfig.SERVER_API_URL + 'app/partner/partnership/$id';
  String? token = await SharedPrefUtils.getAccessToken();
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


Future<ResponseData> getPartnersRanking({Map? queryMap}) async {
  var url = ServerConfig.SERVER_API_URL + 'app/trade_ranking';
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
  print(utf8.decode(response.bodyBytes));
  var jsonBody = json.decode(utf8.decode(response.bodyBytes));

  return ResponseData.fromJSON(jsonBody, response.statusCode);
}
