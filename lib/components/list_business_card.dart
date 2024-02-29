import 'package:Deal_Connect/components/common_item/grey_chip.dart';
import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/model/user_business.dart';
import 'package:Deal_Connect/model/user_business_keyword.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ListBusinessCard extends StatelessWidget {
  final UserBusiness item;

  const ListBusinessCard({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ImageProvider? profileThumbnailImage =
        AssetImage('assets/images/no-image.png');
    ImageProvider? businessThumbnailImage =
        AssetImage('assets/images/no-image.png');

    if (item.has_owner != null &&
        item.has_owner!.has_user_profile != null &&
        item.has_owner!.has_user_profile!.has_profile_image != null) {
      final profileImage = item.has_owner!.has_user_profile!.has_profile_image!;
      profileThumbnailImage = CachedNetworkImageProvider(
        Utils.getImageFilePath(profileImage),
      );
    }

    if (item.has_business_image != null) {
      final businessImage = item.has_business_image!;
      businessThumbnailImage = CachedNetworkImageProvider(
        Utils.getImageFilePath(businessImage),
      );
    }

    return Container(
        decoration: BoxDecoration(
            color: HexColor("#FFFFFF"),
            borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 0.0, vertical: 5.0),
                child: Stack(
                  //overflow: Overflow.visible,
                  clipBehavior: Clip.none,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13.0),
                      child: AspectRatio(
                        aspectRatio: 1.0, // 가로 세로 비율을 1:1로 설정
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: businessThumbnailImage,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0.0,
                      bottom: -4.0,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 30.0,
                          backgroundImage: profileThumbnailImage,
                        ),
                      ),
                    ),
                    if (item.has_owner != null &&
                        item.has_owner!.is_partner != null &&
                        item.has_owner!.is_partner! > 0)
                      Positioned(
                        right: -10, // 우측 여백
                        top: -15, // 상단 여백
                        child: Container(
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            color: SettingStyle.MAIN_COLOR, // 뱃지 배경색
                            shape: BoxShape.circle, // 원형 뱃지
                          ),
                          child: Icon(
                            CupertinoIcons.person_2_fill,
                            color: HexColor("#ffffff"),
                            size: 20,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                item.name,
                style: TextStyle(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                item.has_owner!.name,
                style: TextStyle(color: HexColor("#75A8E4"), fontSize: 12),
              ),
              SizedBox(
                height: 10,
              ),
              if (item.has_keywords != null)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal, // 가로 스크롤
                  child: _buildTags(
                      item.has_keywords as List<UserBusinessKeyword>),
                ),
            ],
          ),
        ));
  }

// 반복태그
  Widget _buildTags(List<UserBusinessKeyword> tagList) {
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
