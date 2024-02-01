import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/pages/history/components/history_detail_list.dart';
import 'package:Deal_Connect/pages/history/components/search_term_select.dart';
import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';

class BusinessHistoryIndex extends StatefulWidget {

  BusinessHistoryIndex({super.key});

  @override
  State<BusinessHistoryIndex> createState() => _BusinessHistoryIndexState();
}

class _BusinessHistoryIndexState extends State<BusinessHistoryIndex> {
  @override
  Widget build(BuildContext context) {
    return DefaultLogoLayout(
      isNotInnerPadding: 'true',
      titleName: '청년 한다발 서초점',
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


