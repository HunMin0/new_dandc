import 'package:flutter/material.dart';

class GroupBoardListCard extends StatelessWidget {
  final String memThumbImagePath;
  final String memNickName;
  final String writeRegDate;
  final String writeText;
  final String writeThumbImagePath;
  final String writeOutLinkPath;
  final int writeViewCnt;

  const GroupBoardListCard(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('이번 모임은 어디서 하는게 좋을까요좋을까요좋을까요좋을까요?', style: TextStyle( fontSize: 16.0, fontWeight: FontWeight.bold ), overflow: TextOverflow.ellipsis,),
          SizedBox(height: 10,),
          _MemberArea(),
          SizedBox(height: 15.0),
          _TextArea(),
          SizedBox(height: 10.0),
          _viewCntArea(),
        ],
      ),
    );
  }

  Row _viewCntArea(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.remove_red_eye_sharp, color: Colors.grey, size: 18.0,),
        SizedBox(width: 3.0),
        Text(writeViewCnt.toString(), style: TextStyle(color: Colors.grey, fontSize: 14.0)),
      ],
    );
  }

  Row _TextArea(){
    return Row(
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
    );
  }

  Row _MemberArea(){
    return Row(
      children: [
        Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/sample/${memThumbImagePath}.jpg'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            SizedBox(width: 5.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  memNickName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
                ),
                Text(
                  writeRegDate,
                  style: TextStyle(color: Colors.grey, fontSize: 11.0),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }

}
