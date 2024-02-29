import 'package:Deal_Connect/components/common_item/grey_chip.dart';
import 'package:Deal_Connect/components/common_item/stack_thumbnail.dart';
import 'package:Deal_Connect/model/partner.dart';
import 'package:Deal_Connect/model/user_keyword.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class ListRankingCard extends StatelessWidget {
  Partner item;
  int index;

  ListRankingCard(
      {required this.item, required this.index,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ImageProvider? profileThumbnailImage =
    AssetImage('assets/images/no-image.png');
    ImageProvider? businessThumbnailImage =
    AssetImage('assets/images/no-image.png');

    if (item != null && item.has_user!.has_user_profile?.has_profile_image != null) {
      final profileImage = item.has_user!.has_user_profile!.has_profile_image!;
      profileThumbnailImage = CachedNetworkImageProvider(
        Utils.getImageFilePath(profileImage),
      );
    }

    if (item != null && item?.has_user!.main_business?.has_business_image != null) {
      final businessImage = item!.has_user!.main_business!.has_business_image!;
      businessThumbnailImage = CachedNetworkImageProvider(
        Utils.getImageFilePath(businessImage),
      );
    }

    String formattedMoney = NumberFormat('#,##0').format(item.total_trade_amount ?? 0);

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
            Container(
              width: 65,
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 2.0),
              decoration: BoxDecoration(
                color: HexColor("#f1f1f1"),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Column(
                children: [
                  Text(
                  '${index + 1}등',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('${Utils.parsePrice(item.total_trade_amount ?? 0)}', style: TextStyle(fontSize: 10.0))
                ],
              ),
            ),
            SizedBox(
              width: 15,
            ),
            _ListRightText(),
            SizedBox(
              width: 18.0,
            ),
            StackThumbNail(profileThumbnailImage: profileThumbnailImage, businessThumbnailImage: businessThumbnailImage),
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
          Text(
            item.has_user!.name,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            (item.has_user!.main_business != null) ? item.has_user!.main_business!.name : '',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
                color: Color(0xFF8c8c8c)),
          ),
          SizedBox(
            height: 5.0,
          ),
          if (item.has_user!.has_keywords != null)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal, // 가로 스크롤
            child: _buildTags(item.has_user!.has_keywords!),
          ),
        ],
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
          child: GreyChip(chipText: '#${tagList[i].keyword}',),
        ));
      } else {
        break;
      }
    }

    return Row(children: tagWidgets);
  }
}
