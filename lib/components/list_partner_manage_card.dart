import 'package:Deal_Connect/model/group_user.dart';
import 'package:Deal_Connect/model/user_keyword.dart';
import 'package:flutter/material.dart';


class ListPartnerManageCard extends StatelessWidget {
  final GroupUser item;

  const ListPartnerManageCard(
      {required this.item,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: _ListCardData(),
    );
  }

  Padding _ListCardData() {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Row(
        children: [
          _ListLeftBg(),
          SizedBox(
            width: 18.0,
          ),
          _ListRightText(),
          item.is_approved == null
              ? Container(
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
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
            item.has_user!.main_business!.name,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
                color: Color(0xFF8c8c8c)),
          ),
          SizedBox(
            height: 5.0,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal, // 가로 스크롤
          ),
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
            ),
          ),
        ),
      ],
    );
  }

  // 반복태그
  Widget _buildTags(List<UserKeyword> tagList) {
    List<Widget> tagWidgets = [];
    for (int i = 0; i < tagList.length; i++) {
      if (i < 3) {
        tagWidgets.add(Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: _cardTag(tagList[i].keyword),
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
