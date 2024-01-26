import 'package:flutter/material.dart';

class GroupListCard extends StatelessWidget {
  final String memThumbImagePath;
  final String memNickName;
  final String writeRegDate;
  final String writeText;
  final String writeThumbImagePath;
  final String writeOutLinkPath;
  final int writeViewCnt;

  const GroupListCard(
      {
        required this.memThumbImagePath,
        required this.memNickName,
        required this.writeRegDate,
        required this.writeText,
        required this.writeThumbImagePath,
        required this.writeOutLinkPath,
        required this.writeViewCnt,
        Key? key
      }
      )
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

  Padding _ListCardData(){
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        children: [
          //  Text('사용자정보 영역'),
          _MemberArea(),
          SizedBox(height: 15.0),
          //  Text('게시글 데이터, 썸네일영역'),
          _TextArea(),
          SizedBox(height: 30.0),
          //  Text('글본사람수 영역'),
          _viewCntArea(),
        ],
      ),
    );
  }

  Container _viewCntArea(){
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.remove_red_eye_sharp, color: Colors.grey),
          SizedBox(width: 5.0),
          Text(writeViewCnt.toString(), style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Container _TextArea(){
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              writeText,
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
            ),
          ),
          if (writeThumbImagePath.isNotEmpty)
          Container(
            margin: EdgeInsets.only(left: 20.0),
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/sample/${writeThumbImagePath}.jpg'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),

        ],
      ),
    );
  }

  Container _MemberArea(){
    return Container(
      child: Row(
        children: [
          Container(
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/sample/${memThumbImagePath}.jpg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                SizedBox(width: 10.0),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        memNickName,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                      Text(
                        writeRegDate,
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Icon(Icons.more_horiz, color: Colors.grey),
        ],
      ),
    );
  }

  /*
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

   */
}
