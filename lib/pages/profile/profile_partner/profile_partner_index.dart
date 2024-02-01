import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/components/list_card.dart';
import 'package:Deal_Connect/components/list_partner_manage_card.dart';
import 'package:Deal_Connect/db/vertical_data.dart';
import 'package:Deal_Connect/pages/profile/other_profile.dart';
import 'package:flutter/cupertino.dart';

class ProfilePartnerIndex extends StatefulWidget {
  const ProfilePartnerIndex({super.key});

  @override
  State<ProfilePartnerIndex> createState() => _ProfilePartnerIndexState();
}

class _ProfilePartnerIndexState extends State<ProfilePartnerIndex> {
  @override
  Widget build(BuildContext context) {
    return DefaultLogoLayout(
        titleName: '내 파트너',
        isNotInnerPadding: 'true',
        child: Column(
          children: [
            Expanded(child: _VerticalList()),
          ],
        ));
  }
}

// 회원 세로 리스트
class _VerticalList extends StatelessWidget {
  bool isNew;

  _VerticalList({this.isNew = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFf5f6f8),
      ),
      child: ListView.builder(
        itemCount: verticalDataList.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> verticalData = verticalDataList[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => OtherProfileIndex()
                ),
              );
            },
            child: ListCard(
                avaterImagePath: verticalData['avaterImagePath'],
                bgImagePath: verticalData['bgImagePath'],
                companyName: verticalData['companyName'],
                userName: verticalData['userName'],
                tagList: verticalData['tagList'],
                hasApprove: false
            ),
          );
        },
      ),
    );
  }
}
