import 'package:Deal_Connect/api/group.dart';
import 'package:Deal_Connect/components/layout/default_search_layout.dart';
import 'package:Deal_Connect/components/list_card.dart';
import 'package:Deal_Connect/components/grid_group_card.dart';
import 'package:Deal_Connect/components/loading.dart';
import 'package:Deal_Connect/components/no_items.dart';
import 'package:Deal_Connect/db/group_data.dart';
import 'package:Deal_Connect/db/vertical_data.dart';
import 'package:Deal_Connect/model/group.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../search/components/partner_card.dart';

class GroupSearchIndex extends StatefulWidget {
  @override
  State<GroupSearchIndex> createState() => _GroupSearchIndexState();
}

class _GroupSearchIndexState extends State<GroupSearchIndex> {
  List<Group>? groups;
  String? searchKeyword = '';
  bool _isLoading = true;

  @override
  void initState() {
    _initGroupData();
    super.initState();
  }

  void _initGroupData() {
    getGroups(queryMap: {
      'keyword': searchKeyword,
    }).then((response) {
      if (response.status == 'success') {
        Iterable iterable = response.data;
        List<Group>? groups =
            List<Group>.from(iterable.map((e) => Group.fromJSON(e)));

        setState(() {
          if (groups != null) {
            this.groups = groups;
            _isLoading = false;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      // 로딩 중 인디케이터 표시
      return Loading();
    }
    return DefaultSearchLayout(
      isNotInnerPadding: 'true',
      onSubmit: (keyword) {
        setState(() {
          searchKeyword = keyword;
        });
        _initGroupData();
      },
      child: groups != null && groups!.isNotEmpty
          ? GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
              padding: EdgeInsets.all(10.0),
              height: double.infinity,
              color: Color(0xFFF5F6FA),
              child: GridView.builder(
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 한 줄에 2개의 아이템
                  crossAxisSpacing: 10.0, // 아이템 간의 가로 간격
                  mainAxisSpacing: 10.0, // 아이템 간의 세로 간격
                  childAspectRatio: 1 / 1.4,
                ),
                itemCount: groups!.length, // 아이템 개수
                itemBuilder: (context, index) {
                  Group item = groups![index];
                  return GestureDetector(
                    onTap: () {
                      print(item.id);
                      Navigator.pushNamed(context, '/group/info',
                          arguments: {'groupId': item.id});
                    },
                    child: GridGroupCard(item: item),
                  );
                },
              ),
                              )
      ) : NoItems(),
    );
  }
}
