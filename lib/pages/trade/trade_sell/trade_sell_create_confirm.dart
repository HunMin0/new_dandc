import 'package:Deal_Connect/api/auth.dart';
import 'package:Deal_Connect/api/business.dart';
import 'package:Deal_Connect/api/partner.dart';
import 'package:Deal_Connect/components/common_item/grey_chip.dart';
import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/components/list_card.dart';
import 'package:Deal_Connect/components/list_user_card.dart';
import 'package:Deal_Connect/components/loading.dart';
import 'package:Deal_Connect/model/user.dart';
import 'package:Deal_Connect/model/user_business.dart';
import 'package:Deal_Connect/model/user_business_keyword.dart';
import 'package:Deal_Connect/utils/shared_pref_utils.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class TradeSellCreateConfirm extends StatefulWidget {
  int? userBusinessId;
  int? partnerUserId;

  TradeSellCreateConfirm({this.userBusinessId, this.partnerUserId, Key? key}) : super(key: key);

  @override
  State<TradeSellCreateConfirm> createState() => _TradeSellCreateConfirmState();
}

class _TradeSellCreateConfirmState extends State<TradeSellCreateConfirm> {
  UserBusiness? userBusiness;
  User? userInfo;

  bool _isLoading = true;
  User? myUser;

  @override
  void initState() {

    _initData();
    _initUserData();
    super.initState();
  }

  void _initUserData() {
    if (widget.partnerUserId != null) {
      getPartnerUser(widget.partnerUserId!).then((response) {
        if (response.status == 'success') {
          User resultData = User.fromJSON(response.data);
          setState(() {
            userInfo = resultData;
          });
        }
      });
    }
  }

  void _initData() {
    if (widget.userBusinessId != null) {
      getUserBusiness(widget.userBusinessId!).then((response) {
        if (response.status == 'success') {
          UserBusiness resultData = UserBusiness.fromJSON(response.data);
          setState(() {
            userBusiness = resultData;
          });
        }
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    String? storeName = '';
    String? storeDescription = '';
    String? storeUserName = '';

    if (_isLoading || userBusiness == null || userInfo == null) {
      // 로딩 중 인디케이터 표시
      return Loading();
    }

    if (userBusiness != null) {
      storeName = userBusiness!.name;
      storeDescription = userBusiness!.description;
      if (userBusiness!.has_owner != null) {
        storeUserName = userBusiness!.has_owner!.name;
      }
    }

    return SingleChildScrollView(
      child: Container(
        color: HexColor("#f5f6fa"),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: HexColor("#ffffff"),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Column(
                children: [
                  _ListLeftBg(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              storeName,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Text(
                          storeDescription ?? '',
                          style: SettingStyle.SUB_GREY_TEXT,
                        ),
                        SizedBox(height: 5),
                        if (userBusiness != null &&
                            userBusiness!.has_keywords != null)
                          _buildTags(userBusiness!.has_keywords!),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Icon(CupertinoIcons.arrow_2_squarepath,
                size: 50, color: HexColor("#5566ff")),
            SizedBox(
              height: 20,
            ),
            if (userInfo != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: ListUserCard(
                  item: userInfo!,
                ),
              ),
            Container(
              color: HexColor("#ffffff"),
              padding: EdgeInsets.all(15.0),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userInfo!.name,
                    style: SettingStyle.TITLE_STYLE
                        .copyWith(color: SettingStyle.MAIN_COLOR),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    '님에게 서비스를 판매합니다.',
                    style: SettingStyle.SUB_TITLE_STYLE,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTags(List<UserBusinessKeyword> tagList) {
    List<Widget> tagWidgets = [];
    for (int i = 0; i < tagList.length; i++) {
      if (i < 3) {
        tagWidgets.add(Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: GreyChip(
            chipText: '#' + tagList[i].keyword,
          ),
        ));
      } else {
        break;
      }
    }
    return Row(children: tagWidgets);
  }

  Stack _ListLeftBg() {
    ImageProvider? profileThumbnailImage =
    AssetImage('assets/images/no-image.png');
    ImageProvider? businessThumbnailImage =
    AssetImage('assets/images/no-image.png');

    if (userBusiness != null &&
        userBusiness!.has_owner != null &&
        userBusiness!.has_owner!.has_user_profile != null &&
        userBusiness!.has_owner!.has_user_profile!.has_profile_image != null) {
      final profileImage =
      userBusiness!.has_owner!.has_user_profile!.has_profile_image!;
      profileThumbnailImage = CachedNetworkImageProvider(
        Utils.getImageFilePath(profileImage),
      );
    }

    if (userBusiness != null && userBusiness!.has_business_image != null) {
      final businessImage = userBusiness!.has_business_image!;
      businessThumbnailImage = CachedNetworkImageProvider(
        Utils.getImageFilePath(businessImage),
      );
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: AspectRatio(
            aspectRatio: 16 / 9,
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
          right: 10.0,
          bottom: -10.0,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 2.0,
              ),
            ),
            child: CircleAvatar(
              radius: 40.0,
              backgroundImage: profileThumbnailImage,
            ),
          ),
        ),
      ],
    );
  }
}
