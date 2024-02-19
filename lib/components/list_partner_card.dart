import 'package:Deal_Connect/components/alert/show_complete_dialog.dart';
import 'package:Deal_Connect/model/group_user.dart';
import 'package:Deal_Connect/model/user.dart';
import 'package:Deal_Connect/model/user_keyword.dart';
import 'package:Deal_Connect/utils/custom_dialog.dart';
import 'package:Deal_Connect/utils/shared_pref_utils.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ListPartnerCard extends StatefulWidget {
  final GroupUser item;
  final bool isManager;
  final bool isMine;
  final VoidCallback onApprovePressed;
  final VoidCallback onDeclinePressed;
  final VoidCallback onOutPressed;
  final VoidCallback onManagerPressed;

  const ListPartnerCard(
      {required this.item,
      required this.onApprovePressed,
      required this.onDeclinePressed,
      required this.onOutPressed,
      required this.onManagerPressed,
      this.isManager = false,
      this.isMine = false,
      Key? key})
      : super(key: key);

  @override
  State<ListPartnerCard> createState() => _ListPartnerCardState();
}

class _ListPartnerCardState extends State<ListPartnerCard> {
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

    if (widget.item.has_user?.has_user_profile?.has_profile_image != null) {
      final profileImage = widget.item.has_user!.has_user_profile!.has_profile_image!;
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
        Navigator.pushNamed(context, '/profile',
            arguments: {'user_id': widget.item.has_user!.id});
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
              Stack(
                //overflow: Overflow.visible,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: businessThumbnailImage,
                        fit: BoxFit.cover,
                      ),
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
                        backgroundImage: profileThumbnailImage,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 18.0,
              ),
              _ListRightText(),
              if (widget.isManager && !widget.isMine)
                widget.item.is_approved == null
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
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFf5f6fa),
                                foregroundColor: Color(0xFFf5f6fa),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                              ),
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
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF333333),
                                foregroundColor: Color(0xFF333333),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        child: Column(
                          children: [
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
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFf5f6fa),
                                foregroundColor: Color(0xFFf5f6fa),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                              ),
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
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF333333),
                                foregroundColor: Color(0xFF333333),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
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
              Text(widget.item.is_leader ? '\u{1F451}' : ''),
              SizedBox(
                width: 2,
              ),
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
          child: _cardTag(tagList[i].keyword as String),
        ));
      } else {
        break;
      }
    }

    return Row(children: tagWidgets);
  }

  // 태그 공통
  Container _cardTag(String text) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFf5f6fa),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 7.0),
        child: Text(
          text,
          style: TextStyle(
              color: Color(0xFF5f5f66),
              fontSize: 11.0,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
