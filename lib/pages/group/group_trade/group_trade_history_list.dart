import 'package:Deal_Connect/api/group_trade.dart';
import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/components/list_group_trade_card.dart';
import 'package:Deal_Connect/components/loading.dart';
import 'package:Deal_Connect/components/no_items.dart';
import 'package:Deal_Connect/model/group_trade.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../history/components/list_card.dart';

class GroupTradeHistoryList extends StatefulWidget {
  int? groupId;
  String? groupName;

  GroupTradeHistoryList({this.groupId, this.groupName, super.key});

  @override
  State<GroupTradeHistoryList> createState() => _GroupTradeHistoryListState();
}

class _GroupTradeHistoryListState extends State<GroupTradeHistoryList> {
  List<GroupTrade> groupTradeList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() {
    getGroupTrades(queryMap: {'group_id': widget.groupId}).then((response) {
      if (response.status == 'success') {
        Iterable iterable = response.data;

        List<GroupTrade>? resData =
            List<GroupTrade>.from(iterable.map((e) => GroupTrade.fromJSON(e)));
        setState(() {
          this.groupTradeList = resData;
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
    return groupTradeList != null && groupTradeList!.isNotEmpty ? Expanded(
      child: Container(
        padding: EdgeInsets.all(13.0),
        color: SettingStyle.GREY_COLOR,
        child: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              _isLoading = true;
            });
            _initData();
          },
          child: ListView.builder(
                  itemCount: groupTradeList.length,
                  itemBuilder: (context, index) {
                    GroupTrade item = groupTradeList[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, '/trade/history/info',
                            arguments: {'tradeId': groupTradeList[index].has_trade!.id});
                      },
                      child: ListGroupTradeCard(item: item),
                    );
                  },
                ),
        ),
      ),
    ) : NoItems();
  }
}
