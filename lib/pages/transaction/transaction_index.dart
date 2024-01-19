import 'package:Deal_Connect/components/layout/default_basic_layout.dart';
import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/pages/group/group_search/group_search_index.dart';
import 'package:Deal_Connect/pages/group/register/register_index.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

// 거래추가
class TransactionIndex extends StatelessWidget {
  const TransactionIndex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width * 0.5 - 25;

    final textStyle = const TextStyle(
        color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold);

    return DefaultBasicLayout(
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
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const GroupSearchIndex(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.easeInOut;

                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));

                          var offsetAnimation = animation.drive(tween);

                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child:
                  Stack(
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
                          )
                        ),
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
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                        const GroupSearchIndex(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.easeInOut;

                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));

                          var offsetAnimation = animation.drive(tween);

                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child:
                  Stack(
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
                          )
                      ),
                    ],
                  ),
                ),
              ]
            ),
            SizedBox(height: 60,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, color: HexColor("#75A8E4"), size: 18,),
                SizedBox(width: 5,),
                Text("거래등록 Tip", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
              ],
            ),
            SizedBox(height: 20,),
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
                Expanded(child: Text("거래내역 등록하시면, 파트너의 승인 이후 거래내역에 저장됩니다..")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
