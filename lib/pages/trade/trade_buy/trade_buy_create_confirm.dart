import 'package:Deal_Connect/components/list_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class TradeBuyCreateConfirm extends StatefulWidget {
  const TradeBuyCreateConfirm({super.key});

  @override
  State<TradeBuyCreateConfirm> createState() => _TradeBuyCreateConfirmState();
}

class _TradeBuyCreateConfirmState extends State<TradeBuyCreateConfirm> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: HexColor("#f5f6fa"),
        child: Column(
          children: [
            Container(
              color: HexColor("#ffffff"),
              padding: EdgeInsets.all(15.0),
              width: MediaQuery.of(context).size.width,
              child: Text(
                "청년한다발 서초점(홍길동) 과 \n박철수(본인)의\n거래내역을 등록합니다.",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: HexColor("#ffffff"),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Column(
                children: [
                  _ListLeftBg(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "청년한다발 서초점",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Text(
                          "이쁜 꽃을 파는 집입니다.",
                          style: TextStyle(fontSize: 16, color: HexColor("#5D5D5D")),
                        ),
                        SizedBox(height: 15),
                        _buildTags(['키워드1', '키워드2']),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Icon(Icons.compare_arrows_sharp, size: 60, color: HexColor("#5566ff")),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ListCard(
                  bgImagePath: "main_sample02",
                  avaterImagePath: "main_sample_avater2",
                  companyName: "회사명",
                  userName: "박철수",
                  tagList: ["#키워드1", "#키워드2"]
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTags(List<String> tagList) {
    List<Widget> tagWidgets = [];
    for (int i = 0; i < tagList.length; i++) {
      if (i < 3) {
        tagWidgets.add(Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: _cardTag(tagList[i]),
        ));
      } else {
        break;
      }
    }
    return Row(children: tagWidgets);
  }

// 태그 공통
  Container _cardTag(String text) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFf5f6fa),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 7.0),
        child: Text(
          text,
          style: TextStyle(
              color: Color(0xFF5f5f66),
              fontSize: 11.0,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Row _iconText(IconData prefixIcon, String text) {
    return Row(
      children: [
        Icon(
          prefixIcon,
          color: HexColor("#ABABAB"),
          size: 18,
        ),
        SizedBox(
          width: 10,
        ),
        Text(text)
      ],
    );
  }

  Stack _ListLeftBg() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/sample/main_sample01.jpg'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
        Positioned(
          right: 10.0,
          bottom: -10.0,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 2.0,
              ),
            ),
            child: CircleAvatar(
              radius: 40.0,
              backgroundImage:
                  AssetImage('assets/images/sample/main_sample_avater.jpg'),
            ),
          ),
        ),
      ],
    );
  }
}
