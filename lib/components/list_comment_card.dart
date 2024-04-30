import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/model/board_write_comment.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListCommentCard extends StatelessWidget {
  final BoardWriteComment item;

  const ListCommentCard({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ImageProvider? profileThumbnailImage =
        AssetImage('assets/images/no-image.png');

    if (item.has_writer!.profile?.has_profile_image != null) {
      final profileImage =
          item.has_writer!.profile!.has_profile_image!;
      profileThumbnailImage = CachedNetworkImageProvider(
        Utils.getImageFilePath(profileImage),
      );
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 15.0,
                backgroundImage: profileThumbnailImage,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.has_writer!.name,
                    style: SettingStyle.NORMAL_TEXT_STYLE
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  Text(Utils.formatTimeAgoFromString(item.created_at), style: SettingStyle.SUB_GREY_TEXT,)
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(item.comment, style: SettingStyle.NORMAL_TEXT_STYLE,),
        ],
      ),
    );
  }
}
