import 'package:flutter/material.dart';

class PostListCard extends StatelessWidget {
  final String bgImagePath;
  final String postTitle;
  final String postSubject;
  final int comment;
  final String date;
  final bool newMark;

  const PostListCard(
      {required this.bgImagePath,
      required this.postTitle,
      required this.postSubject,
      required this.comment,
      required this.date,
      required this.newMark,
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
      child: _PostListCardData(),
    );
  }

  Padding _PostListCardData() {
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        postTitle.length > 16
                            ? '${postTitle.substring(0, 16)}...'
                            : postTitle,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16.0),
                      ),
                      SizedBox(
                        width: 2.0,
                      ),
                      if (newMark)
                        Icon(
                          Icons.announcement_rounded,
                          color: Color(0xFF75a8e4),
                          size: 18.0,
                        ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 4.0,
              ),
              Text(
                postSubject.length > 45
                    ? '${postSubject.substring(0, 45)}...'
                    : postSubject,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13.0,
                    color: Color(0xFF8c8c8c)),
              ),
            ],
          ),
          SizedBox(height: 5.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _comment(comment),
              Text(date, style: TextStyle(fontSize: 12.0, color: Colors.grey[500]),),
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

  // 댓글 공통
  Container _comment(int num) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF75a8e4),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 7.0),
        child: Text(
          '댓글 ${num.toString()}',
          style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 11.0,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
