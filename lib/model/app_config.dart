class AppConfig {
  final int id;
  final int app_major_ver;
  final int app_minor_ver;
  final int app_build_ver;
  final String created_at;
  final String updated_at;

  AppConfig({
    required this.id,
    required this.app_major_ver,
    required this.app_minor_ver,
    required this.app_build_ver,
    required this.created_at,
    required this.updated_at,
  });

  factory AppConfig.fromJSON(Map<String, dynamic> json) {
    return AppConfig(
      id: int.parse(json['id'].toString()),
      app_major_ver: int.parse(json['app_major_ver'].toString()),
      app_minor_ver: int.parse(json['app_minor_ver'].toString()),
      app_build_ver: int.parse(json['app_build_ver'].toString()),
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
}