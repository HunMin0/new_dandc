import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class ListCard extends StatelessWidget {
  final String created_at;
  final String companyName;
  final String companyCeo;
  final String trade_name;
  final int trade_price;
  final String buyer;

  const ListCard(
      {required this.created_at,
      required this.companyCeo,
      required this.companyName,
      required this.trade_name,
      required this.trade_price,
      required this.buyer,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final historyNormalFontStyle = TextStyle(
      fontSize: 13.0,
    );

    final historyTitleFontStyle = TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold
    );

    return Container(
      color: HexColor("#FFFFFF"),
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _ListLeftBg(),
                SizedBox(
                  width: 18,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('하남돼지집2', style: historyTitleFontStyle, ),
                          Spacer(),
                          Text(created_at, style: historyNormalFontStyle),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Text('대표자명', style: historyNormalFontStyle),
                          Spacer(),
                          Text(companyCeo, style: historyNormalFontStyle),
                        ],
                      ),
                      Row(
                        children: [
                          Text('거래 항목', style: historyNormalFontStyle),
                          Spacer(),
                          Text(trade_name, style: historyNormalFontStyle),
                        ],
                      ),
                      Row(
                        children: [
                          Text('거래 금액', style: historyNormalFontStyle),
                          Spacer(),
                          Text(trade_price.toString() + '원', style: historyNormalFontStyle),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Divider(
            thickness: 10,
            height: 10,
            color: HexColor('#F5F6FA'),
          )
        ],
      ),
    );
  }

  Stack _ListLeftBg() {
    return Stack(
      //overflow: Overflow.visible,
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 70,
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
          right: -8.0,
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
              AssetImage('assets/images/sample/main_sample_avater2.jpg'),
            ),
          ),
        ),
      ],
    );
  }
}
