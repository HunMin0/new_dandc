import 'package:Deal_Connect/components/common_item/grey_chip.dart';
import 'package:Deal_Connect/components/common_item/stack_thumbnail.dart';
import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/model/user.dart';
import 'package:Deal_Connect/model/user_keyword.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ListPartnerCard extends StatelessWidget {
  final User? item;

  final bool? hasButton;
  final VoidCallback onApprovePressed;
  final VoidCallback onDeletePressed;

  ListPartnerCard(
      {this.hasButton = false,
      required this.item,
      required this.onApprovePressed,
      required this.onDeletePressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ImageProvider? profileThumbnailImage =
        const AssetImage('assets/images/no-image.png');
    ImageProvider? businessThumbnailImage =
        const AssetImage('assets/images/no-image.png');

    if (item != null && item!.profile?.has_profile_image != null) {
      final profileImage = item!.profile!.has_profile_image!;
      profileThumbnailImage = CachedNetworkImageProvider(
        Utils.getImageFilePath(profileImage),
      );
    }

    if (item != null && item?.main_business?.has_business_image != null) {
      final businessImage = item!.main_business!.has_business_image!;
      businessThumbnailImage = CachedNetworkImageProvider(
        Utils.getImageFilePath(businessImage),
      );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          children: [
            StackThumbNail(
                businessThumbnailImage: businessThumbnailImage,
                profileThumbnailImage: profileThumbnailImage),
            const SizedBox(
              width: 18.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item != null ? item!.name : '',
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16.0),
                  ),
                  if (item != null && item!.main_business != null)
                    Text(
                      item!.main_business!.name ?? '',
                      style: SettingStyle.SUB_GREY_TEXT,
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (item != null &&
                      item!.has_keywords != null &&
                      item!.has_keywords!.isNotEmpty)
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal, // 가로 스크롤
                      child:
                          _buildTags(item!.has_keywords as List<UserKeyword>),
                    ),
                ],
              ),
            ),
            if (hasButton == true)
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      onApprovePressed();
                    },
                    child: const Text(
                      '승인',
                      style: TextStyle(
                        color: Color(0xff333333),
                      ),
                    ),
                    style: SettingStyle.BUTTON_STYLE,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      onDeletePressed();
                    },
                    child: const Text(
                      '삭제',
                      style: TextStyle(
                        color: Color(0xffffffff),
                      ),
                    ),
                    style: SettingStyle.BUTTON_STYLE.copyWith( backgroundColor: MaterialStatePropertyAll(HexColor("#222222"))),
                  ),
                ],
              ),

          ],
        ),
      ),
    );
  }

  // 반복태그
  Widget _buildTags(List<UserKeyword> tagList) {
    List<Widget> tagWidgets = [];
    for (int i = 0; i < tagList.length; i++) {
      if (i < 3) {
        tagWidgets.add(Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: GreyChip(chipText: '#' + tagList[i].keyword as String),
        ));
      } else {
        break;
      }
    }

    return Row(children: tagWidgets);
  }
}
