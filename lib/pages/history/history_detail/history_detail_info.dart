import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/pages/history/history_detail/reciept_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class HistoryDetailInfo extends StatefulWidget {
  const HistoryDetailInfo({super.key});

  @override
  State<HistoryDetailInfo> createState() => _HistoryDetailInfoState();
}

class _HistoryDetailInfoState extends State<HistoryDetailInfo> {
  @override
  Widget build(BuildContext context) {
    return DefaultLogoLayout(
      titleName: '거래내역 상세',
      isNotInnerPadding: 'true',
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Spacer(),
                      Container(
                        width: 100,
                        child: Column(
                          children: [
                            _ListLeftBg(),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              '(나)하남돼지집',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '홍길동',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Image(
                            image: AssetImage('assets/images/right_arrow.png'),
                            width: 20,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '2,500,000원',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          Text('판매')
                        ],
                      ),
                      Spacer(),
                      Container(
                        width: 100,
                        child: Column(
                          children: [
                            _ListLeftBg(),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              '김철수',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '다이소, 김밥천국, 틈새라면',
                              style: TextStyle(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 10,
              color: HexColor('#F5F6FA'),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "거래 정보",
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => RecieptView()));
                        },
                        child: Text("영수증 확인", style: TextStyle( color: HexColor("#75A8E4"), fontWeight: FontWeight.bold ),),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: HexColor("#F5F6FA"),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("거래일자"),
                            Spacer(),
                            Text("2023-01-01 15:23")
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [Text("거래항목"), Spacer(), Text("삼겹살, 목살")],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [Text("거래금액"), Spacer(), Text("320,000원")],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "[김철수]님 한마디",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      padding: EdgeInsets.all(10.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: HexColor("#F5F6FA"),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text("맛깔나게 !맛깔나게 잘먹었습니다!맛깔나게 잘먹었습니다!맛깔나게 잘먹었습니다!맛깔나게 잘먹었습니다!맛깔나게 잘먹었습니다!맛깔나게 잘먹었습니다!맛깔나게 잘먹었습니다!맛깔나게 잘먹었습니다!맛깔나게 잘먹었습니다!맛깔나게 잘먹었습니다!맛깔나게 잘먹었습니다!맛깔나게 잘먹었습니다!맛깔나게 잘먹었습니다!맛깔나게 잘먹었습니다!맛깔나게 잘먹었습니다!맛깔나게 잘먹었습니다!맛깔나게 잘먹었습니다!맛깔나게 잘먹었습니다!맛깔나게 잘먹었습니다!")),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "[하남돼지집]님 한마디",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      padding: EdgeInsets.all(10.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: HexColor("#F5F6FA"),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text("와주셔서 감사합니다!")),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Stack _ListLeftBg() {
    return Stack(
      //overflow: Overflow.visible,
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 100,
          height: 70,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/sample/main_sample01.jpg'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        Positioned(
          left: -8.0,
          bottom: -8.0,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 2.0,
              ),
            ),
            child: CircleAvatar(
              radius: 18.0,
              backgroundImage:
                  AssetImage('assets/images/sample/main_sample_avater.jpg'),
            ),
          ),
        ),
      ],
    );
  }
}
