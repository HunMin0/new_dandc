import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/components/list_card.dart';
import 'package:Deal_Connect/components/grid_group_card.dart';
import 'package:Deal_Connect/components/list_group_card.dart';
import 'package:Deal_Connect/db/group_data.dart';
import 'package:Deal_Connect/db/group_sample_data.dart';
import 'package:Deal_Connect/db/vertical_data.dart';
import 'package:Deal_Connect/pages/profile/other_profile.dart';
import 'package:flutter/cupertino.dart';

class ProfileGroupIndex extends StatefulWidget {
  const ProfileGroupIndex({super.key});

  @override
  State<ProfileGroupIndex> createState() => _ProfileGroupIndexState();
}

class _ProfileGroupIndexState extends State<ProfileGroupIndex> {
  @override
  Widget build(BuildContext context) {
    return DefaultLogoLayout(
        titleName: '소속 그룹',
        isNotInnerPadding: 'true',
        child: Column(
          children: [
            Expanded(child: _VerticalList()),
          ],
        ));
  }
}

class _VerticalList extends StatelessWidget {
  _VerticalList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFf5f6f8),
      ),
      child: ListView.builder(
        itemCount: groupSampleDataList.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> groupData = groupSampleDataList[index];

          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/group/info', arguments: {
                'group_id' : groupData['id']
              });
            },
            child: ListGroupCard(
                bgImagePath: groupData['bgImagePath'],
                groupName: groupData['groupName'],
                tagList: groupData['tagList'],
            ),
          );
        },
      ),
    );
  }
}
