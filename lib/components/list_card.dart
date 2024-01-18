import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  final String bgImagePath;
  final String avaterImagePath;
  final String companyName;
  final String userName;
  final List<String> tagList;
  final bool newMark;

  const ListCard(
      {required this.bgImagePath,
      required this.avaterImagePath,
      required this.companyName,
      required this.userName,
      required this.tagList,
      required this.newMark,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      width: double.infinity,
      height: 110,
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
          Row(
            children: [
              Text(
                userName,
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 16.0),
              ),
              SizedBox(
                width: 2.0,
              ),
              if (newMark)
                Icon(
                  Icons.check_circle,
                  color: Color(0xFF75a8e4),
                  size: 15.0,
                ),
            ],
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            companyName,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
                color: Color(0xFF8c8c8c)),
          ),
          SizedBox(
            height: 10.0,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal, // 가로 스크롤
            child: _buildTags(tagList),
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
            image: DecorationImage(
              image: AssetImage('assets/images/sample/${bgImagePath}.jpg'),
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
                  AssetImage('assets/images/sample/${avaterImagePath}.jpg'),
            ),
          ),
        ),
      ],
    );
  }

  // 반복태그
  Widget _buildTags(List<String> tagList) {
    List<Widget> tagWidgets = [];
    for (int i = 0; i < tagList.length; i++) {
      if (i < 3) {
        tagWidgets.add(Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: _cardTag(tagList[i]),
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
