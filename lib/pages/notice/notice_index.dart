import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/components/list_notice_card.dart';
import 'package:Deal_Connect/components/list_ranking_card.dart';
import 'package:Deal_Connect/db/notice_data.dart';
import 'package:Deal_Connect/pages/profile/other_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../db/group_ranking_data.dart';

class NoticeIndex extends StatefulWidget {
  const NoticeIndex({super.key});

  @override
  State<NoticeIndex> createState() => _NoticeIndexState();
}

class _NoticeIndexState extends State<NoticeIndex> {
  @override
  Widget build(BuildContext context) {
    return DefaultLogoLayout(
        titleName: '알림',
        isNotInnerPadding: 'true',
        child: Container(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: noticeData.length,
                    itemBuilder: (context, index) {
                      final data = noticeData[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(builder: (context) => OtherProfileIndex()
                            ),
                          );
                        },
                        child: ListNoticeCard(
                          title: data['title'],
                          created_at: data['created_at'],
                          profile_img: data['profile_img'],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
    );
  }
}
