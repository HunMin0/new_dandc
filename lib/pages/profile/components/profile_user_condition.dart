import 'package:Deal_Connect/pages/default_page.dart';
import 'package:Deal_Connect/pages/history/history_index.dart';
import 'package:Deal_Connect/pages/profile/other_profile.dart';
import 'package:Deal_Connect/pages/profile/profile_partner/profile_partner_index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileUserCondition extends StatelessWidget {
  final int partner;
  final int company;
  final dynamic history;

  const ProfileUserCondition({
    required this.partner,
    required this.company,
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
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => ProfilePartnerIndex()
                ),
              );
            },
            child: _buildUserTab(
              partner.toString(),
              '파트너',
            ),
          ),
          _buildTabLine(),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/profile/groups');
            },
            child: _buildUserTab(
              company.toString(),
              '소속그룹',
            ),
          ),
          _buildTabLine(),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => DefaultPage(currentIndex: 1)),
              );
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