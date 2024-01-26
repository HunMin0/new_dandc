import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/pages/history/components/history_detail_list.dart';
import 'package:Deal_Connect/pages/history/components/search_term_select.dart';
import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';

class HistoryDetailIndex extends StatefulWidget {
  String historyType;

  HistoryDetailIndex({required this.historyType, super.key});

  @override
  State<HistoryDetailIndex> createState() => _HistoryDetailIndexState();
}

class _HistoryDetailIndexState extends State<HistoryDetailIndex> {
  @override
  Widget build(BuildContext context) {
    return DefaultLogoLayout(
      isNotInnerPadding: 'true',
      titleName: widget.historyType == 'mine' ? '나의 승인 내역' : '파트너 승인 요청 내역',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('총 15 건'),
                Spacer(),
                SearchTermSelect(),
              ],
            ),
          ),
          SizedBox(
            height: 10,
            child: Container(
              decoration: BoxDecoration(color: HexColor('#F5F6FA')),
            ),
          ),
          Expanded(child: HistoryDetailList()),
        ],
      ),
    );
  }
}


