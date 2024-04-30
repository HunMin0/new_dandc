import 'package:Deal_Connect/model/file.dart';

class AdManage {
  final int id;
  final String ad_type;
  final String ad_link;
  final int? ad_image_id;
  final File? has_image;

  AdManage({
    required this.id,
    required this.ad_type,
    required this.ad_link,
    this.ad_image_id,
    this.has_image,
  });

  factory AdManage.fromJSON(Map<String, dynamic> json) {
    var has_image =
        json['has_image'] != null ? File.fromJSON(json['has_image']) : null;

    return AdManage(
      id: json['id'],
      ad_type: json['ad_type'],
      ad_link: json['ad_link'],
      ad_image_id: json['ad_image_id'],
      has_image: has_image,
    );
  }
}
