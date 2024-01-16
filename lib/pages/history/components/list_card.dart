import 'package:flutter/cupertino.dart';
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
                Container(
                  width: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 80,
                        child: Image(
                            image: AssetImage(
                                'assets/images/sample/main_sample01.jpg'),
                            fit: BoxFit.cover),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        companyName,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('거래일자'),
                          Spacer(),
                          Text(created_at),
                        ],
                      ),
                      Row(
                        children: [
                          Text('대표자명'),
                          Spacer(),
                          Text(companyCeo),
                        ],
                      ),
                      Row(
                        children: [
                          Text('거래 항목'),
                          Spacer(),
                          Text(trade_name),
                        ],
                      ),
                      Row(
                        children: [
                          Text('거래 금액'),
                          Spacer(),
                          Text(trade_price.toString()),
                        ],
                      ),
                      Row(
                        children: [
                          Text('구매자'),
                          Spacer(),
                          Text(buyer),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
            child: Container(
              decoration: BoxDecoration(color: HexColor('#F5F6FA')),
            ),
          ),
        ],
      ),
    );
  }
}
