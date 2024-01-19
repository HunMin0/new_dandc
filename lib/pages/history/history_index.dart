import 'package:Deal_Connect/components/layout/default_basic_layout.dart';
import 'package:Deal_Connect/db/trade_data.dart';
import 'package:Deal_Connect/db/vertical_data.dart';
import 'package:Deal_Connect/pages/history/components/history_tab_bar.dart';
import 'package:Deal_Connect/pages/history/components/list_card.dart';
import 'package:Deal_Connect/pages/history/history_detail/history_detail_index.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class HistoryIndex extends StatelessWidget {
  const HistoryIndex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultBasicLayout(
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '나의 브릿지 현황',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                          ],
                        ),

                        SizedBox(
                          height: 13,
                        ),
                        Container(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 13.0, vertical: 8),
                          decoration: BoxDecoration(
                            color: HexColor('#F5F6FA'),
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('판매내역'),
                                        Text(
                                          '788,793원',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold, fontSize: 18),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Container(
                                      width: 1,
                                      height: 40,
                                      color: Color(0xFFDDDDDD),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('구매내역'),
                                        Text(
                                          '788,793원',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 7.0, horizontal: 13),
                                decoration: BoxDecoration(
                                  color: HexColor('#FFFFFF'),
                                  borderRadius: BorderRadius.circular(9),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "판매",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          "구매",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: LinearProgressIndicator(
                                            value: 0.6,
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(10)),
                                            minHeight: 6,
                                            backgroundColor: HexColor('#D9D9D9'),
                                            valueColor: AlwaysStoppedAnimation<Color>(
                                                HexColor('#75A8E4')),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Row(
                                      children: [
                                        Text(
                                          "60건",
                                          style: TextStyle(
                                              fontSize: 13, fontWeight: FontWeight.w500),
                                        ),
                                        Spacer(),
                                        Text(
                                          "37건",
                                          style: TextStyle(
                                              fontSize: 13, fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              RichText(
                                text: const TextSpan(
                                  text: '총 누적거래 ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF666666),
                                      fontSize: 13),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: '97건',
                                      style: TextStyle(
                                        color: Color(0xFF75A8E4),
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' 중 ',
                                    ),
                                    TextSpan(
                                      text: '판매내역이 ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '23건',
                                      style: TextStyle(
                                        color: Color(0xFF75A8E4),
                                      ),
                                    ),
                                    TextSpan(
                                      text: " 많아요\u{1f525}",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: HexColor('#75A8E4'),
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '나의 파트너들 중 누가 제일 큰손일까요!?',
                                      style: TextStyle(
                                        color: HexColor('#FFFFFF'),
                                        fontSize: 13,
                                      ),
                                    ),
                                    Text(
                                      '랭킹 보러가기',
                                      style: TextStyle(
                                          color: HexColor('#FFFFFF'),
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.chevron_right,
                                color: Colors.white,
                                size: 24.0,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding:
                          const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                          decoration: BoxDecoration(
                            color: HexColor('#F5F6FA'),
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryDetailIndex(historyType: 'mine',)));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.add_alert_rounded,
                                        color: HexColor('#666666'),
                                        size: 20.0,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text('나의 승인 내역'),
                                      const Spacer(),
                                      Text(
                                        '10건',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        Icons.chevron_right,
                                        color: HexColor('#666666'),
                                        size: 20.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                color: HexColor('#D9D9D9'),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryDetailIndex(historyType: 'partner',)));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.list_alt,
                                        color: HexColor('#666666'),
                                        size: 20.0,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text('파트너 승인 요청 내역'),
                                      const Spacer(),
                                      Text(
                                        '3건',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        Icons.chevron_right,
                                        color: HexColor('#666666'),
                                        size: 20.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ])
            )
          ];
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: HistoryTabBar()),
          ],
        ),
      )
    );
  }
}
