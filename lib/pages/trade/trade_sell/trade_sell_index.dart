import 'package:Deal_Connect/components/layout/default_basic_layout.dart';
import 'package:Deal_Connect/components/layout/default_layout.dart';
import 'package:Deal_Connect/components/layout/default_search_layout.dart';
import 'package:Deal_Connect/components/list_business_card.dart';
import 'package:Deal_Connect/components/list_card.dart';
import 'package:Deal_Connect/db/company_data.dart';
import 'package:Deal_Connect/db/vertical_data.dart';
import 'package:Deal_Connect/pages/business/components/business_tab_bar.dart';
import 'package:Deal_Connect/pages/trade/trade_buy/trade_buy_create.dart';
import 'package:Deal_Connect/pages/trade/trade_sell/trade_sell_create.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

// 사업장찾기
class TradeSellIndex extends StatefulWidget {
  String? searchKeyword;

  // super()를 사용하여 부모 클래스의 생성자 호출
  TradeSellIndex({
    this.searchKeyword = '',
    Key? key,
  }) : super(key: key);

  @override
  State<TradeSellIndex> createState() => _TradeSellIndexState();
}

class _TradeSellIndexState extends State<TradeSellIndex> {
  @override
  Widget build(BuildContext context) {
    return DefaultSearchLayout(
      isNotInnerPadding: 'true',
      onSubmit: (keyword) {
        setState(() {
          widget.searchKeyword = keyword;
        });
      },
      child: Container(
        color: HexColor('#F5F6FA'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text('최근 검색', style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            Expanded(child: _VerticalList())
          ],
        ),
      ),
    );
  }
}


// 회원 세로 리스트
class _VerticalList extends StatelessWidget {
  _VerticalList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFf5f6f8),
      ),
      child: ListView.builder(
        itemCount: verticalDataList.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> verticalData = verticalDataList[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => TradeSellCreate()),
              );
            },
            child: ListCard(
              avaterImagePath: verticalData['avaterImagePath'],
              bgImagePath: verticalData['bgImagePath'],
              companyName: verticalData['companyName'],
              userName: verticalData['userName'],
              tagList: verticalData['tagList'],
            ),
          );
        },
      ),
    );
  }
}

