import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/pages/group/group_trade/group_trade_history_list.dart';
import 'package:Deal_Connect/pages/group/group_trade/group_trade_mine_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GroupTradeDetail extends StatefulWidget {
  const GroupTradeDetail({super.key});

  @override
  State<GroupTradeDetail> createState() => _GroupTradeDetailState();
}

class _GroupTradeDetailState extends State<GroupTradeDetail> {
  int _currentIndex = 0;
  final _pages = [
    GroupTradeHistoryList(), // 상세거래내역
    GroupTradeMineList(), // 내 거래내역
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultLogoLayout(
      isNotInnerPadding: 'true',
      titleName: '서초구 고기집 사장모임',
      child: Container(
        child: Column(
          children: [
            _currentIndex == 0 ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        '전체 거래내역',
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _currentIndex = 1;
                            print(_currentIndex);
                          });
                        },
                        child: Text(
                          '내 거래내역',
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
                  SizedBox(
                    height: 14.0,
                  ),
                ],
              ),
            )
                : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        '내 거래내역',
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _currentIndex = 0;
                          });
                        },
                        child: Text(
                          '전체 거래내역',
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
                  SizedBox(
                    height: 14.0,
                  ),
                ],
              ),
            ),
            _pages[_currentIndex],
          ],
        ),
      ),
    );
  }
}


