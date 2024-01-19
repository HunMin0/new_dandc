import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ListBusinessCard extends StatelessWidget {
  final String bgImagePath;
  final String avaterImagePath;
  final String companyName;
  final List<String> tagList;

  const ListBusinessCard(
      {required this.bgImagePath,
        required this.avaterImagePath,
        required this.companyName,
        required this.tagList,
        Key? key})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: HexColor("#FFFFFF"),
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
              child: _ListBg(),
            ),
            SizedBox(height: 5,),
            Text(companyName, style: TextStyle(fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
            Text("홍길동", style: TextStyle(color: HexColor("#75A8E4"), fontSize: 12),),
            SizedBox(height: 5,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal, // 가로 스크롤
              child: _buildTags(tagList),
            ),
          ],
        ),
      )
    );
  }


  Stack _ListBg() {
    return Stack(
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
                  image: AssetImage('assets/images/sample/${bgImagePath}.jpg'),
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
