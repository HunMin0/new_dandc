import 'package:Deal_Connect/components/common_item/stack_thumbnail.dart';
import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/model/user.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';

class PartnerCard extends StatelessWidget {
  User item;

  PartnerCard({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    ImageProvider? profileThumbnailImage =
        AssetImage('assets/images/no-image.png');
    ImageProvider? businessThumbnailImage =
        AssetImage('assets/images/no-image.png');

    if (item.profile?.has_profile_image != null) {
      final profileImage = item.profile!.has_profile_image!;
      profileThumbnailImage = CachedNetworkImageProvider(
        Utils.getImageFilePath(profileImage),
      );
    }

    if (item.main_business?.has_business_image != null) {
      final businessImage = item.main_business!.has_business_image!;
      businessThumbnailImage = CachedNetworkImageProvider(
        Utils.getImageFilePath(businessImage),
      );
    }

    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10.0),
          width: 110,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: HexColor("#F5F6FA")),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              StackThumbNail(
                  profileThumbnailImage: profileThumbnailImage,
                  businessThumbnailImage: businessThumbnailImage),
              const SizedBox(
                height: 8,
              ),
              Text(
                item.name,
                style: SettingStyle.SUB_TITLE_STYLE,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 1,
              ),
              if (item.main_business != null)
                Text(item.main_business!.name ?? '',
                    style: SettingStyle.SUB_GREY_TEXT,
                    overflow: TextOverflow.ellipsis),
              Spacer(),
            ],
          ),
        ),
        SizedBox(width: 15)
      ],
    );
  }
}
