class ResponseData {
  final dynamic status;
  final dynamic message;
  final dynamic data;
  final int statusCode;

  ResponseData({
    this.status,
    this.message,
    this.data,
    required this.statusCode,
  });

  factory ResponseData.fromJSON(Map<String, dynamic> json, int statusCode) {
    // print('ResponseData.status : ${json['status']}');
    // print('ResponseData.message : ${json['message']}');
    // if (json['data'] != null && json['data'].length < 100) {
    // print('ResponseData.data : ${json['data']}');
    // }

    return ResponseData(
      status: json['status'],
      message: json['message'],
      data: json['data'],
      statusCode: statusCode,
    );
  }
}