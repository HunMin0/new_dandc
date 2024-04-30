import 'package:Deal_Connect/model/file.dart';

class Category {
  final int id;
  final int? category_icon_id;
  final String name;
  final File? has_category_icon_image;

  Category({
    required this.id,
    this.category_icon_id,
    required this.name,
    this.has_category_icon_image,
  });

  factory Category.fromJSON(Map<String, dynamic> json) {
    var has_category_icon_image = json['has_category_icon_image'] != null ? File.fromJSON(json['has_category_icon_image']) : null;

    return Category(
      id: json['id'],
      name: json['name'],
      category_icon_id: json['category_icon_id'],
      has_category_icon_image: has_category_icon_image
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category_icon_id': category_icon_id,
      'has_category_icon_image': has_category_icon_image?.toJson(),
    };
  }
}