import 'package:Deal_Connect/model/file.dart';

class Category {
  final int id;
  final int category_icon_id;
  final String name;
  final File? has_category_icon_image;

  Category({
    required this.id,
    required this.category_icon_id,
    required this.name,
    required this.has_category_icon_image,
  });

  factory Category.fromJSON(Map<String, dynamic> json) {
    var has_category_icon_image = json['category_icon_id'] != null ? File.fromJSON(json['has_category_icon_image']) : null;

    return Category(
      id: json['id'],
      name: json['name'],
      category_icon_id: json['category_icon_id'],
      has_category_icon_image: has_category_icon_image
    );
  }
}