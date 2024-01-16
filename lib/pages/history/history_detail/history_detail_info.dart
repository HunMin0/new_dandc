import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(height: 30,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(),
                    Container(
                      height: 50,
                      width: 50,
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/sample/main_sample01.jpg'),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Image(image: AssetImage('assets/images/right_arrow.png'), width: 20,),
                    SizedBox(width: 10,),
                    Container(
                      height: 50,
                      width: 50,
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/sample/main_sample02.jpg'),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(height: 20,),
                Text('최지원님께서 회원님께 요청한\n구매등록이 완료되었습니다', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
