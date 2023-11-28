class File {
  final int id;
  final String hash_name;
  final String origin_name;
  final String ext;
  final String path;
  final int size;
  final String created_at;
  final String updated_at;
  final String? mobile_hash_name;
  final String? mobile_path;

  File({
    required this.id,
    required this.hash_name,
    required this.origin_name,
    required this.ext,
    required this.path,
    required this.size,
    required this.created_at,
    required this.updated_at,
    this.mobile_hash_name,
    this.mobile_path,
  });

  factory File.fromJSON(Map<String, dynamic> json) {
    return File(
      id: json['id'],
      hash_name: json['hash_name'],
      origin_name: json['origin_name'],
      ext: json['ext'],
      path: json['path'],
      size: json['size'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      mobile_hash_name: json['mobile_hash_name'],
      mobile_path: json['mobile_path'],
    );
  }
}