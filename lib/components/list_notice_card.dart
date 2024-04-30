import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/model/push_message.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';

class ListNoticeCard extends StatelessWidget {
  final PushMessage item;

  const ListNoticeCard(
      {required this.item,
        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ImageProvider? profileThumbnailImage =
    const AssetImage('assets/images/no-image.png');

    if (item.has_user != null && item.has_user!.profile?.has_profile_image != null) {
      final profileImage = item.has_user!.profile!.has_profile_image!;
      profileThumbnailImage = CachedNetworkImageProvider(
        Utils.getImageFilePath(profileImage),
      );
    }

    return Column(
      children: [
        Container(
          color: HexColor("#ffffff"),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: profileThumbnailImage,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.title, style: SettingStyle.NORMAL_TEXT_STYLE.copyWith(fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis,),
                        Text(item.content, maxLines: 3, overflow: TextOverflow.ellipsis),
                        Text(item.created_at, style: SettingStyle.SUB_GREY_TEXT,)
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 40,)
      ],
    );
  }
}
