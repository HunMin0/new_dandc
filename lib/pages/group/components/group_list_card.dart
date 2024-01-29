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

}
