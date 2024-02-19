import 'package:Deal_Connect/model/file.dart';
import 'package:Deal_Connect/model/user.dart';
import 'package:Deal_Connect/model/user_business_keyword.dart';

class UserBusiness {
  final int id;
  final String name;
  final String? website;
  final String? phone;
  final String? address1;
  final String? address2;
  final User? has_owner;
  final File? has_business_image;
  final List<UserBusinessKeyword>? has_keywords;
  final int? group_image_id;
  final String? description;
  final String? created_at;
  final String? updated_at;

  UserBusiness({
    required this.id,
    this.website,
    this.phone,
    this.address1,
    this.address2,
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
    var has_business_image = json['business_image_id'] != null ? File.fromJSON(json['has_business_image']) : null;
    var has_owner = json['has_owner'] != null ? User.fromJSON(json['has_owner']) : null;
    var has_keywords = null;
    if (json['has_keywords'] != null) {
      Iterable iterable = json['has_keywords'];
      List<UserBusinessKeyword> list = List<UserBusinessKeyword>.from(iterable.map((e) => UserBusinessKeyword.fromJSON(e)));
      has_keywords = list;
    }


    return UserBusiness(
        id: json['id'],
        name: json['name'],
        phone: json['phone'],
        website: json['website'],
        address1: json['address1'],
        address2: json['address2'],
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