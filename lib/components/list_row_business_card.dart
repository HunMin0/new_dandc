import 'package:Deal_Connect/components/common_item/grey_chip.dart';
import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/model/user_business.dart';
import 'package:Deal_Connect/model/user_business_keyword.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ListRowBusinessCard extends StatelessWidget {
  final UserBusiness item;

  const ListRowBusinessCard({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ImageProvider? backgroundImage;

    if (item.has_business_image != null && item.has_business_image != null) {
      backgroundImage = CachedNetworkImageProvider(
        Utils.getImageFilePath(item.has_business_image!),
      );
    } else {
      backgroundImage = AssetImage('assets/images/no-image.png');
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
            Stack(
              //overflow: Overflow.visible,
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: backgroundImage,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 18.0,
            ),
            _ListRightText(),
          ],
        ),
      ),
    );
  }

  Expanded _ListRightText() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(item.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  )),
              SizedBox(
                width: 3,
              ),
              if (item.is_main)
                GreyChip(
                  chipText: '대표',
                ),
            ],
          ),
          Row(
            children: [
              Text(
                item.address1 ?? '',
                style: SettingStyle.SUB_GREY_TEXT,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              if (item.has_keywords != null)
                _buildTags(item.has_keywords as List<UserBusinessKeyword>),
            ],
          ),
        ],
      ),
    );
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
