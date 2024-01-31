import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';

class ListGroupCard extends StatelessWidget {
  final String bgImagePath;
  final String groupName;
  final List<String> tagList = ['test', 'test', ' test'];

  ListGroupCard(
      {required this.bgImagePath,
        required this.groupName,
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
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
                child: Container(
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
              ),
              SizedBox(height: 5,),
              Text(groupName, style: TextStyle(fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
              SizedBox(height: 10,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal, // 가로 스크롤
                child: _buildTags(tagList),
              ),
            ],
          ),
        )
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

