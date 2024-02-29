import 'package:Deal_Connect/model/file.dart';
import 'package:Deal_Connect/model/user.dart';
import 'package:Deal_Connect/model/user_business_keyword.dart';

class UserBusiness {
  final int id;
  final int user_id;
  final int user_business_category_id;
  final String name;
  final String? website;
  final String? phone;
  final String? address1;
  final String? address2;
  final String? work_time;
  final String? holiday;
  final String? weekend;
  final bool has_holiday;
  final bool has_weekend;
  final bool is_main;
  final User? has_owner;
  final File? has_business_image;
  final List<UserBusinessKeyword>? has_keywords;
  final int? group_image_id;
  final String? description;
  final String? created_at;
  final String? updated_at;


  UserBusiness({
    required this.id,
    required this.user_id,
    required this.user_business_category_id,
    this.website,
    this.phone,
    this.address1,
    this.address2,
    this.work_time,
    this.holiday,
    this.weekend,
    required this.has_holiday,
    required this.has_weekend,
    required this.is_main,
    this.has_owner,
    this.group_image_id,
    required this.name,
    this.description,
    this.has_keywords,
    this.has_business_image,
    required this.created_at,
    required this.updated_at,
  });

  factory UserBusiness.fromJSON(Map<String, dynamic> json) {
    var has_business_image = json['has_business_image'] != null ? File.fromJSON(json['has_business_image']) : null;
    var has_owner = json['has_owner'] != null ? User.fromJSON(json['has_owner']) : null;
    var has_keywords = null;
    if (json['has_keywords'] != null) {
      Iterable iterable = json['has_keywords'];
      List<UserBusinessKeyword> list = List<UserBusinessKeyword>.from(iterable.map((e) => UserBusinessKeyword.fromJSON(e)));
      has_keywords = list;
    }


    return UserBusiness(
        id: json['id'],
        user_id: json['user_id'],
        user_business_category_id: json['user_business_category_id'],
        name: json['name'],
        phone: json['phone'],
        website: json['website'],
        address1: json['address1'],
        address2: json['address2'],
        work_time: json['work_time'],
        holiday: json['holiday'],
        weekend: json['weekend'],
        has_holiday: json['has_holiday'],
        has_weekend: json['has_weekend'],
        is_main: json['is_main'],
        description: json['description'],
        group_image_id: json['group_image_id'],
        created_at: json['created_at'],
        updated_at: json['updated_at'],
        has_keywords: has_keywords,
        has_owner: has_owner,
        has_business_image: has_business_image
    );
  }
}