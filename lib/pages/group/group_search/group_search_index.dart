import 'package:Deal_Connect/components/layout/default_search_layout.dart';
import 'package:Deal_Connect/components/list_card.dart';
import 'package:Deal_Connect/components/list_group_card.dart';
import 'package:Deal_Connect/db/group_data.dart';
import 'package:Deal_Connect/db/vertical_data.dart';
import 'package:Deal_Connect/pages/group/group_view.dart';
import 'package:Deal_Connect/pages/search/components/search_keyword_item.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../search/components/partner_card.dart';

class GroupSearchIndex extends StatefulWidget {
  String? searchKeyword;

  GroupSearchIndex({
    this.searchKeyword = '',
    Key? key,
  }) : super(key: key);

  @override
  State<GroupSearchIndex> createState() => _GroupSearchIndexState();
}

class _GroupSearchIndexState extends State<GroupSearchIndex> {
  @override
  Widget build(BuildContext context) {
    return DefaultSearchLayout(
      isNotInnerPadding: 'true',
      onSubmit: (keyword) {
        setState(() {
          widget.searchKeyword = keyword;
        });
      },
      child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Expanded(child: _buildContainer())),
    );
  }

  Container _buildContainer() {
    return Container(
      padding: EdgeInsets.all(10.0),
      color: Color(0xFFF5F6FA),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 한 줄에 2개의 아이템
          crossAxisSpacing: 10.0, // 아이템 간의 가로 간격
          mainAxisSpacing: 10.0, // 아이템 간의 세로 간격
          childAspectRatio: 1 / 1.4,
        ),
        itemCount: groupDataList.length, // 아이템 개수
        itemBuilder: (context, index) {
          Map<String, dynamic> groupData = groupDataList[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => GroupView(
                          id: groupData['id'],
                        )),
              );
            },
            child: Container(
              child: ListGroupCard(
                bgImagePath: groupData['imagePath'],
                groupName: groupData['title'],
              ),
            ),
          );
        },
      ),
    );
  }
}
