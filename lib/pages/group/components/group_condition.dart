import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/pages/group/group_partner/group_partner_index.dart';
import 'package:Deal_Connect/pages/group/group_trade/group_trade_index.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:flutter/material.dart';

class GroupCondition extends StatelessWidget {
  final int partner;
  final int history;
  final int groupId;
  final String groupName;

  const GroupCondition({
    required this.partner,
    required this.history,
    required this.groupId,
    required this.groupName,

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
              Navigator.pushNamed(context, '/group/partner', arguments: { 'groupId': groupId, 'groupName': groupName });
            },
            child: _buildUserTab(
              partner.toString(),
              '파트너',
            ),
          ),
          _buildTabLine(),
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, '/group/trade', arguments: { 'groupId': groupId, 'groupName': groupName });
            },
            child: _buildUserTab(
              Utils.moneyGenerator(history),
              '거래내역',
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildUserTab(String tabData, String tabTitle) {
  return Container(
    width: 120.0,
    child: Column(
      children: [
        Text(
          tabData,
          style: SettingStyle.TITLE_STYLE,
        ),
        Text(
          tabTitle,
          style: SettingStyle.SMALL_TEXT_STYLE,
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