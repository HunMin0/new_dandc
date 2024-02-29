import 'package:Deal_Connect/components/common_item/color_chip.dart';
import 'package:Deal_Connect/components/common_item/grey_chip.dart';
import 'package:Deal_Connect/components/common_item/stack_thumbnail.dart';
import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/model/trade.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class ListTradeCard extends StatelessWidget {
  Trade item;

  ListTradeCard({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ImageProvider? profileThumbnailImage =
        const AssetImage('assets/images/no-image.png');
    ImageProvider? businessThumbnailImage =
        const AssetImage('assets/images/no-image.png');

    if (item.has_business_owner != null &&
        item.has_business_owner!.has_user_profile != null &&
        item.has_business_owner!.has_user_profile!.has_profile_image != null) {
      final profileImage =
          item.has_business_owner!.has_user_profile!.has_profile_image!;
      profileThumbnailImage = CachedNetworkImageProvider(
        Utils.getImageFilePath(profileImage),
      );
    }

    if (item.has_business?.has_business_image != null) {
      final businessImage = item.has_business!.has_business_image!;
      businessThumbnailImage = CachedNetworkImageProvider(
        Utils.getImageFilePath(businessImage),
      );
    }

    return Container(
      color: HexColor("#FFFFFF"),
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StackThumbNail(
                    businessThumbnailImage: businessThumbnailImage,
                    profileThumbnailImage: profileThumbnailImage),
                SizedBox(
                  width: 18,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                              item.has_business != null
                                  ? item.has_business!.name
                                  : '',
                              style: SettingStyle.SUB_TITLE_STYLE),
                          Spacer(),
                          if (item.trade_status == 'rejected')
                            ColorChip(
                              color: HexColor("#aa5544"),
                              textColor: HexColor("#ffffff"),
                              chipText: '반려',
                            ),
                          if (item.trade_status == 'pending')
                            ColorChip(
                              color: HexColor("#44aa44"),
                              textColor: HexColor("#ffffff"),
                              chipText: '승인대기',
                            ),
                          if (item.trade_status == 'approved')
                          ColorChip(
                              color: HexColor("#4455aa"),
                              textColor: HexColor("#ffffff"),
                              chipText: '승인',
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '거래일자',
                            style: SettingStyle.SMALL_TEXT_STYLE,
                          ),
                          Spacer(),
                          Text(item.traded_at!.substring(0, 16),
                              style: SettingStyle.SMALL_TEXT_STYLE),
                        ],
                      ),
                      Row(
                        children: [
                          Text('대표자명', style: SettingStyle.SMALL_TEXT_STYLE),
                          Spacer(),
                          Text(
                              item.has_business_owner != null
                                  ? item.has_business_owner!.name
                                  : '',
                              style: SettingStyle.SMALL_TEXT_STYLE),
                        ],
                      ),
                      Row(
                        children: [
                          Text('구매자명', style: SettingStyle.SMALL_TEXT_STYLE),
                          Spacer(),
                          Text(
                              item.has_buy_user != null
                                  ? item.has_buy_user!.name
                                  : '',
                              style: SettingStyle.SMALL_TEXT_STYLE),
                        ],
                      ),
                      Row(
                        children: [
                          Text('거래 항목', style: SettingStyle.SMALL_TEXT_STYLE),
                          Spacer(),
                          Text(item.trade_services,
                              style: SettingStyle.SMALL_TEXT_STYLE),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('거래 금액',
                              style: SettingStyle.SMALL_TEXT_STYLE),
                          Spacer(),
                          Text(Utils.parsePrice(item.price),
                              style: SettingStyle.SMALL_TEXT_STYLE),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Divider(
            thickness: 10,
            height: 10,
            color: HexColor('#F5F6FA'),
          )
        ],
      ),
    );
  }

  Stack _ListLeftBg() {
    return Stack(
      //overflow: Overflow.visible,
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/sample/main_sample01.jpg'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        Positioned(
          right: -8.0,
          bottom: -8.0,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 2.0,
              ),
            ),
            child: CircleAvatar(
              radius: 18.0,
              backgroundImage:
                  AssetImage('assets/images/sample/main_sample_avater2.jpg'),
            ),
          ),
        ),
      ],
    );
  }
}
