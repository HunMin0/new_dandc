import 'package:Deal_Connect/pages/group/group_partner/group_partner_index.dart';
import 'package:Deal_Connect/pages/group/group_trade/group_trade_index.dart';
import 'package:flutter/material.dart';

class GroupCondition extends StatelessWidget {
  final int partner;
  final dynamic history;

  const GroupCondition({
    required this.partner,
    required this.history,

    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => GroupPartnerIndex()));
            },
            child: _buildUserTab(
              partner.toString(),
              '파트너',
            ),
          ),
          _buildTabLine(),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => GroupTradeIndex()));
            },
            child: _buildUserTab(
              history,
              '거래내역',
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildUserTab(String tabData, String tabTitle) {
  final tabDataStyle = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 20.0,
  );
  final tabTitleStyle = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12.0,
  );

  return Container(
    width: 120.0,
    child: Column(
      children: [
        Text(
          tabData,
          style: tabDataStyle,
        ),
        Text(
          tabTitle,
          style: tabTitleStyle,
        ),
      ],
    ),
  );
}

Widget _buildTabLine() {
  return Container(
    width: 1.0,
    height: double.infinity,
    color: const Color(0xFFD9D9D9),
  );
}