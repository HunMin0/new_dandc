import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/model/board_write.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PostListCard extends StatelessWidget {
  final BoardWrite item;

  const PostListCard(
      {required this.item,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> imgUrls = [];
    if (item.has_files != null && item.has_files!.isNotEmpty) {
      imgUrls.addAll(
          item.has_files!.map((e) => Utils.getImageFilePath(e.has_file!)));
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12.0 , left: 12.0, right:12.0),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          children: [
            if (imgUrls.isNotEmpty)
            Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(imgUrls[0]),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            const SizedBox(
              width: 18.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              item.title,
                              overflow: TextOverflow.ellipsis,
                              style: SettingStyle.TITLE_STYLE,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        item.content,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: SettingStyle.SUB_GREY_TEXT,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF75a8e4),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 7.0),
                          child: Text(
                            item.has_board!.has_group!.name,
                            style: const TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 11.0,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      Text(item.created_at.substring(0, 16), style: TextStyle(fontSize: 12.0, color: Colors.grey[500]),),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
