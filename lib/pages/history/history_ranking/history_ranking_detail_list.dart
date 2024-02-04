import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/components/list_ranking_card.dart';
import 'package:Deal_Connect/db/group_ranking_data.dart';
import 'package:Deal_Connect/db/ranking_data.dart';
import 'package:Deal_Connect/pages/profile/other_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';

class HistoryRankingDetailList extends StatefulWidget {
  const HistoryRankingDetailList({super.key});

  @override
  State<HistoryRankingDetailList> createState() => _HistoryRankingDetailListState();
}

class _HistoryRankingDetailListState extends State<HistoryRankingDetailList> {
  @override
  Widget build(BuildContext context) {
    return DefaultLogoLayout(
      titleName: '최대 판매금액',
      isNotInnerPadding: 'true',
      child: Container(
        color: HexColor("#f5f6fa"),
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: groupRankingData.length,
                  itemBuilder: (context, index) {
                    final data = groupRankingData[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(builder: (context) => OtherProfileIndex()
                          ),
                        );
                      },
                      child: ListRankingCard(
                        bgImagePath: data['bgImagePath'],
                        avaterImagePath: data['avaterImagePath'],
                        companyName: data['companyName'],
                        userName: data['userName'],
                        ranking: data['ranking'],
                        tagList: List<String>.from(data['tagList']),
                        money: data['money'],
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
