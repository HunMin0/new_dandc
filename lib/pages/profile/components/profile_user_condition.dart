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
          _buildUserTab(
            partner.toString(),
            '파트너',
          ),
          _buildTabLine(),
          _buildUserTab(
            company.toString(),
            '업체',
          ),
          _buildTabLine(),
          _buildUserTab(
            history,
            '거래내역',
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