import 'package:Deal_Connect/components/layout/default_basic_layout.dart';
import 'package:Deal_Connect/pages/group/group_search/group_search_index.dart';
import 'package:Deal_Connect/pages/trade/trade_buy/trade_buy_index.dart';
import 'package:Deal_Connect/pages/trade/trade_sell/trade_sell_index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

// 거래추가
class TradeIndex extends StatelessWidget {
  const TradeIndex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width * 0.5 - 25;

    final boxStyle = ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF75A8E4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      elevation: 0,
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0),
    );

    final textStyle = const TextStyle(
        color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold);

    return DefaultBasicLayout(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '거래를 등록하고 파트너와\n거래내역을 쌓아보세요',
                style: textStyle,
              ),
              const SizedBox(
                height: 50.0,
              ),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => TradeBuyIndex()),
                        );
                      },
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: 130, // 버튼의 세로 크기
                            width: screenWidth,
                            decoration: BoxDecoration(
                              color: HexColor('#F5F6FA'),
                              borderRadius: BorderRadius.circular(
                                  10.0), // 여기서 10.0은 원하는 반지름 값입니다.
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 50.0), // 이미지와 버튼 사이의 간격 조절
                                Text(
                                  '구매등록',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                              top: -25,
                              left: 40,
                              child: Image(
                                image: AssetImage(
                                    'assets/images/icons/trade_button_icon_buy.png'),
                                height: 90,
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => TradeSellIndex()),
                        );
                      },
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: 130, // 버튼의 세로 크기
                            width: screenWidth,
                            decoration: BoxDecoration(
                              color: HexColor('#F5F6FA'),
                              borderRadius: BorderRadius.circular(
                                  10.0), // 여기서 10.0은 원하는 반지름 값입니다.
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 50.0), // 이미지와 버튼 사이의 간격 조절
                                Text(
                                  '판매등록',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                              top: -25,
                              left: (screenWidth - 70) / 2,
                              child: Image(
                                image: AssetImage(
                                    'assets/images/icons/trade_button_icon_sell.png'),
                                height: 90,
                              )),
                        ],
                      ),
                    ),
                  ]),
              SizedBox(
                height: 60,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: HexColor("#75A8E4"),
                    size: 18,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "거래등록 Tip",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("· "),
                  Expanded(child: Text("거래내역 등록 전에 등록하고자 하는 업체를 파트너로 저장해주세요.")),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("· "),
                  Expanded(child: Text("거래내역 등록 전에 거래 영수증 등 증빙 자료를 준비해주세요.")),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("· "),
                  Expanded(child: Text("거래내역 등록하시면, 파트너의 승인 이후 거래내역에 저장됩니다.")),
                ],
              ),
              SizedBox(height: 20.0,),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: boxStyle,
                      onPressed: () {},
                      child: Text(
                        '거래 추가 기능 사용 설명',
                        style: textStyle.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
