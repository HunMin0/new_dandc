import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/components/list_ranking_card.dart';
import 'package:Deal_Connect/db/ranking_data.dart';
import 'package:Deal_Connect/pages/group/group_index.dart';
import 'package:Deal_Connect/pages/history/history_ranking/history_ranking_detail_list.dart';
import 'package:Deal_Connect/pages/profile/other_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class HistoryRankingIndex extends StatefulWidget {
  const HistoryRankingIndex({super.key});

  @override
  State<HistoryRankingIndex> createState() => _HistoryRankingIndexState();
}

class _HistoryRankingIndexState extends State<HistoryRankingIndex> {
  @override
  Widget build(BuildContext context) {
    TextStyle subTitle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

    return DefaultLogoLayout(
        titleName: 'Deal & Connect 랭킹',
        isNotInnerPadding: 'true',
        child: SingleChildScrollView(
          child: Container(
            color: HexColor("f5f6fa"),
            child: Column(
              children: [
                Divider(thickness: 10, height: 10, color: HexColor("f5f6fa")),
                _buildTitle(
                    "최대 판매금액(최근 30일 기준)", "더보기", HistoryRankingDetailList()),
                Divider(thickness: 10, height: 10, color: HexColor("f5f6fa")),
                Column(
                  children: [
                    for (final data in rankingData)
                      GestureDetector(
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
                      )
                  ],
                ),
                _buildTitle(
                    "최대 구매금액(최근 30일 기준)", "더보기", HistoryRankingDetailList()),
                Divider(thickness: 10, height: 10, color: HexColor("f5f6fa")),
                Column(
                  children: [
                    for (final data in rankingData)
                    ListRankingCard(
                      bgImagePath: data['bgImagePath'],
                      avaterImagePath: data['avaterImagePath'],
                      companyName: data['companyName'],
                      userName: data['userName'],
                      ranking: data['ranking'],
                      tagList: List<String>.from(data['tagList']),
                      money: data['money'],
                    )
                  ],
                ),
                _buildTitle(
                    "최다 거래내역(최근 30일 기준)", "더보기", HistoryRankingDetailList()),
                Divider(thickness: 10, height: 10, color: HexColor("f5f6fa")),
                Column(
                  children: [
                    for (final data in rankingData)
                      ListRankingCard(
                        bgImagePath: data['bgImagePath'],
                        avaterImagePath: data['avaterImagePath'],
                        companyName: data['companyName'],
                        userName: data['userName'],
                        ranking: data['ranking'],
                        tagList: List<String>.from(data['tagList']),
                        money: data['money'],
                      )
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Container _buildTitle(String text, String buttonText, Widget goto) {
    return Container(
      color: HexColor("#ffffff"),
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                text,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context, CupertinoPageRoute(builder: (context) => goto));
                },
                child: Text(
                  buttonText,
                  style: TextStyle(
                    color: Color(0xff333333),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFf5f6fa),
                  foregroundColor: Color(0xFFf5f6fa),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
