import 'package:Deal_Connect/components/common_item/grey_chip.dart';
import 'package:Deal_Connect/components/common_item/stack_thumbnail.dart';
import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/model/group_user.dart';
import 'package:Deal_Connect/model/user.dart';
import 'package:Deal_Connect/model/user_keyword.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ListGroupUserCard extends StatefulWidget {
  final GroupUser item;
  final bool isManager;
  final bool isMine;
  final VoidCallback onApprovePressed;
  final VoidCallback onDeclinePressed;
  final VoidCallback onOutPressed;
  final VoidCallback onManagerPressed;
  final VoidCallback onManagerDownPressed;

  const ListGroupUserCard(
      {required this.item,
      required this.onApprovePressed,
      required this.onDeclinePressed,
      required this.onOutPressed,
      required this.onManagerPressed,
      required this.onManagerDownPressed,
      this.isManager = false,
      this.isMine = false,
      Key? key})
      : super(key: key);

  @override
  State<ListGroupUserCard> createState() => _ListGroupUserCardState();
}

class _ListGroupUserCardState extends State<ListGroupUserCard> {
  User? myUser;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider? profileThumbnailImage =
        AssetImage('assets/images/no-image.png');
    ImageProvider? businessThumbnailImage =
        AssetImage('assets/images/no-image.png');

    if (widget.item.has_user?.profile?.has_profile_image != null) {
      final profileImage = widget.item.has_user!.profile!.has_profile_image!;
      profileThumbnailImage = CachedNetworkImageProvider(
        Utils.getImageFilePath(profileImage),
      );
    }

    if (widget.item.has_user?.main_business?.has_business_image != null) {
      final businessImage =
          widget.item.has_user!.main_business!.has_business_image!;
      businessThumbnailImage = CachedNetworkImageProvider(
        Utils.getImageFilePath(businessImage),
      );
    }


    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/profile/partner/info',
            arguments: {'userId': widget.item.has_user!.id});
      },
      child: Container(
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
              SizedBox(
                width: 18.0,
              ),
              _ListRightText(),
              if (widget.isManager && !widget.isMine)
                widget.item.is_approved == false && widget.item.is_deleted == false
                    ? Container(
                        child: Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                widget.onApprovePressed();
                              },
                              child: Text(
                                '승인',
                                style: TextStyle(
                                  color: Color(0xff333333),
                                ),
                              ),
                              style: SettingStyle.BUTTON_STYLE,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                widget.onDeclinePressed();
                              },
                              child: Text(
                                '반려',
                                style: TextStyle(
                                  color: Color(0xffffffff),
                                ),
                              ),
                              style: SettingStyle.BUTTON_STYLE.copyWith(
                                backgroundColor: MaterialStateProperty.all(Color(0xFF333333)),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        child: Column(
                          children: [
                            widget.item.is_leader == true ? ElevatedButton(
                              onPressed: () {
                                widget.onManagerDownPressed();
                              },
                              child: Text(
                                '강등',
                                style: TextStyle(
                                  color: Color(0xff333333),
                                ),
                              ),
                              style: SettingStyle.BUTTON_STYLE,
                            ) :
                            ElevatedButton(
                              onPressed: () {
                                widget.onManagerPressed();
                              },
                              child: Text(
                                '위임',
                                style: TextStyle(
                                  color: Color(0xff333333),
                                ),
                              ),
                              style: SettingStyle.BUTTON_STYLE,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                widget.onOutPressed();
                              },
                              child: Text(
                                '방출',
                                style: TextStyle(
                                  color: Color(0xffffffff),
                                ),
                              ),
                              style: SettingStyle.BUTTON_STYLE.copyWith(
                                backgroundColor: MaterialStateProperty.all(Color(0xFF333333)),
                              ),
                            ),

                          ],
                        ),
                      )
            ],
          ),
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
              if (widget.item.is_leader)
              Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFf5f6fa),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 7.0),
                    child: Text(
                      "관리자",
                      style: TextStyle(
                          color: Color(0xFF5f5f66),
                          fontSize: 11.0,
                          fontWeight: FontWeight.w500),
                    ),
                  )
              ),
              SizedBox(width: 3,),
              Text(
                widget.item.has_user!.name,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),
              ),
            ],
          ),
          SizedBox(
            height: 5.0,
          ),
          if (widget.item.has_user!.main_business != null)
            Text(
              widget.item.has_user!.main_business!.name ?? '',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                  color: Color(0xFF8c8c8c)),
            ),
          SizedBox(
            height: 5.0,
          ),
          if (widget.item.has_user!.has_keywords != null &&
              widget.item.has_user!.has_keywords!.isNotEmpty)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal, // 가로 스크롤
              child:
                  _buildTags(widget.item.has_user!.has_keywords as List<UserKeyword>),
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
          child: GreyChip(chipText: '#' + tagList[i].keyword as String),
        ));
      } else {
        break;
      }
    }

    return Row(children: tagWidgets);
  }
}
