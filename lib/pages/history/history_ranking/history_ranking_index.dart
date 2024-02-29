import 'package:Deal_Connect/api/partner.dart';
import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/components/list_ranking_card.dart';
import 'package:Deal_Connect/components/loading.dart';
import 'package:Deal_Connect/components/no_items.dart';
import 'package:Deal_Connect/db/group_ranking_data.dart';
import 'package:Deal_Connect/db/ranking_data.dart';
import 'package:Deal_Connect/model/partner.dart';
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
  bool _isLoading = true;
  List<Partner> partnerRankingList = [];


  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() async {
    getPartnersRanking()
        .then((response) {
      if (response.status == 'success') {
        Iterable iterable = response.data;
        List<Partner> dataList =
            List<Partner>.from(iterable.map((e) => Partner.fromJSON(e)));
        setState(() {
          this.partnerRankingList = dataList;
        });
      }
    });
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      // 로딩 중 인디케이터 표시
      return Loading();
    }
    return DefaultLogoLayout(
      titleName: 'Deal&Connect 랭킹',
      isNotInnerPadding: 'true',
      child: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _isLoading = true;
          });
          _initData();
        },
        child: Container(
          color: HexColor("#f5f6fa"),
          padding: EdgeInsets.all(15.0),
          child: partnerRankingList != null && partnerRankingList.isNotEmpty ? Column(
            children: [
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: partnerRankingList.length,
                    itemBuilder: (context, index) {
                      final item = partnerRankingList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => OtherProfileIndex()),
                          );
                        },
                        child: ListRankingCard(item: item, index: index),
                      );
                    }),
              ),
            ],
          ) : NoItems(),
        ),
      ),
    );
  }
}
