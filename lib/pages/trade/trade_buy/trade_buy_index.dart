import 'package:Deal_Connect/components/layout/default_basic_layout.dart';
import 'package:Deal_Connect/components/layout/default_layout.dart';
import 'package:Deal_Connect/components/layout/default_search_layout.dart';
import 'package:Deal_Connect/components/list_business_card.dart';
import 'package:Deal_Connect/db/company_data.dart';
import 'package:Deal_Connect/pages/business/components/business_tab_bar.dart';
import 'package:Deal_Connect/pages/trade/trade_buy/trade_buy_create.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

// 사업장찾기
class TradeBuyIndex extends StatefulWidget {
  String? searchKeyword;

  // super()를 사용하여 부모 클래스의 생성자 호출
  TradeBuyIndex({
    this.searchKeyword = '',
    Key? key,
  }) : super(key: key);

  @override
  State<TradeBuyIndex> createState() => _TradeBuyIndexState();
}

class _TradeBuyIndexState extends State<TradeBuyIndex> {
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
              Expanded(
                child: companyDataList.isNotEmpty
                    ? GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 한 줄에 2개의 아이템
                    crossAxisSpacing: 10.0, // 아이템 간의 가로 간격
                    mainAxisSpacing: 10.0, // 아이템 간의 세로 간격
                    childAspectRatio: 1 / 1.4,
                  ),
                  itemCount: companyDataList.length, // 아이템 개수
                  itemBuilder: (context, index) {
                    Map<String, dynamic> companyData = companyDataList[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => TradeBuyCreate()),
                        );
                      },
                      child: ListBusinessCard(
                        bgImagePath: companyData['bgImagePath'],
                        avaterImagePath: companyData['avaterImagePath'],
                        companyName: companyData['companyName'],
                        tagList : companyData['tagList'],
                      ),
                    );
                  },
                ) : const Text('등록된 데이터가 없습니다'),
              ),
            ],
          ),
        ),
    );
  }
}
