class UserBusinessKeyword {
  final int id;
  final int user_business_id;
  final String keyword;

  UserBusinessKeyword({
    required this.id,
    required this.user_business_id,
    required this.keyword,
  });

  factory UserBusinessKeyword.fromJSON(Map<String, dynamic> json) {

    return UserBusinessKeyword(
      id: json['id'],
      user_business_id: json['user_business_id'],
      keyword: json['keyword'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_business_id': user_business_id,
      'keyword': keyword,
    };
  }
}