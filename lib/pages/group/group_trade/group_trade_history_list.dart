import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/db/trade_data.dart';
import 'package:Deal_Connect/pages/group/group_trade/group_trade_mine_list.dart';
import 'package:Deal_Connect/pages/history/history_detail/history_detail_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../history/components/list_card.dart';

class GroupTradeHistoryList extends StatefulWidget {
  const GroupTradeHistoryList({super.key});

  @override
  State<GroupTradeHistoryList> createState() => _GroupTradeHistoryListState();
}

class _GroupTradeHistoryListState extends State<GroupTradeHistoryList> {

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: tradeDataList.isNotEmpty
            ? ListView.builder(
          itemCount: tradeDataList.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> tradeData = tradeDataList[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryDetailInfo()));
              },
              child: ListCard(
                created_at: tradeData['created_at'],
                companyCeo: tradeData['companyCeo'],
                companyName: tradeData['companyName'],
                trade_name: tradeData['trade_name'],
                trade_price: tradeData['trade_price'],
                buyer: tradeData['buyer'],
              ),
            );
          },
        )
            : const Text('등록된 데이터가 없습니다'),
      ),
    );
  }
}

