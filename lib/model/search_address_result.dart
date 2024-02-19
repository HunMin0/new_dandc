class SearchAddressResult {
  final String addr;
  // final String lat;
  // final String lon;
  final String zonecode;
  final String userSelectedType;
  final String roadAddress;
  final String jibunAddress;

  SearchAddressResult({
    required this.addr,
    // required this.lat,
    // required this.lon,
    required this.zonecode,
    required this.userSelectedType,
    required this.roadAddress,
    required this.jibunAddress,
  });

  factory SearchAddressResult.fromJSON(Map<String, dynamic> json) {
    return SearchAddressResult(
      addr: json['addr'],
      // lat: json['lat'],
      // lon: json['lon'],
      zonecode: json['zonecode'],
      userSelectedType: json['userSelectedType'],
      roadAddress: json['roadAddress'],
      jibunAddress: json['jibunAddress'],
    );
  }
}