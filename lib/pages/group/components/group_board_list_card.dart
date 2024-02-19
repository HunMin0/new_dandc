import 'package:Deal_Connect/model/board_write.dart';
import 'package:Deal_Connect/model/file.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GroupBoardListCard extends StatelessWidget {
  final BoardWrite item;

  const GroupBoardListCard({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: _ListCardData(),
    );
  }

  Padding _ListCardData() {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.title,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 10,
          ),
          _MemberArea(),
          SizedBox(height: 15.0),
          _TextArea(),
          SizedBox(height: 10.0),
          _viewCntArea(),
        ],
      ),
    );
  }

  Row _viewCntArea() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.remove_red_eye_sharp,
          color: Colors.grey,
          size: 18.0,
        ),
        SizedBox(width: 3.0),
        Text(item.hits.toString(),
            style: TextStyle(color: Colors.grey, fontSize: 14.0)),
      ],
    );
  }

  Row _TextArea() {
    List<String> imgUrls = [];
    if (item != null) {
      if (item!.has_files != null && item!.has_files!.isNotEmpty) {
        imgUrls.addAll(
            item!.has_files!.map((e) => Utils.getImageFilePath(e.has_file!)));
      }
    }

    String? firstImgUrl;

    if (imgUrls.isNotEmpty) {
      firstImgUrl = imgUrls[0];
      print(firstImgUrl);
    } else {
      // imgUrls가 비어있을 때 대체 값을 설정하거나, 다른 처리를 수행
      firstImgUrl = null; // 또는 기본 이미지 URL 등
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            item.content,
            overflow: TextOverflow.ellipsis,
            maxLines: 5,
          ),
        ),
        if (imgUrls.isNotEmpty)
          Container(
              margin: EdgeInsets.only(left: 20.0),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(imgUrls[0]),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
          )
      ],
    );
  }

  Row _MemberArea() {
    ImageProvider? avatarImage;

    if (item.has_writer != null &&
        item.has_writer!.has_user_profile != null &&
        item.has_writer!.has_user_profile!.has_profile_image != null) {
      avatarImage = CachedNetworkImageProvider(
        Utils.getImageFilePath(
            item.has_writer!.has_user_profile!.has_profile_image!),
      );
    } else {
      avatarImage = AssetImage('assets/images/no-image.png');
    }

    return Row(
      children: [
        Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: avatarImage,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            SizedBox(width: 5.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.has_writer!.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
                ),
                Text(
                  item.created_at,
                  style: TextStyle(color: Colors.grey, fontSize: 11.0),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
