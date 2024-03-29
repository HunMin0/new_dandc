import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ListGroupCard extends StatelessWidget {
  final String bgImagePath;
  final String groupName;
  final List<String> tagList;

  const ListGroupCard(
      {required this.bgImagePath,
        required this.groupName,
        required this.tagList,
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
          Text(groupName,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
              )),
          SizedBox(
            height: 5,
          ),
          Text("간단설명", overflow: TextOverflow.ellipsis,),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              _buildTags(tagList),
            ],
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
