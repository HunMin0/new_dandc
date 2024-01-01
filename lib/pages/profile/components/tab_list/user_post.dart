import 'package:Deal_Connect/components/post_list_card.dart';
import 'package:flutter/material.dart';

class UserPost extends StatelessWidget {
  const UserPost({
    super.key,
    required this.postDataList,
  });

  final List<Map<String, dynamic>> postDataList;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFf5f6f8),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 14.0,
          left: 14.0,
          right: 14.0,
        ),
        child: ListView.builder(
          itemCount: postDataList.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> postData = postDataList[index];

            return GestureDetector(
              onTap: () {
                print('클릭했다~');
              },
              child: PostListCard(
                bgImagePath: postData['bgImagePath'],
                postTitle: postData['postTitle'],
                postSubject: postData['postSubject'],
                comment: postData['comment'],
                date: postData['date'],
                newMark: postData['newMark'],
              ),
            );
          },
        ),
      ),
    );
  }
}
