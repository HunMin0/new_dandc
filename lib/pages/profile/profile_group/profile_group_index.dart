import 'package:Deal_Connect/api/group.dart';
import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/components/list_group_card.dart';
import 'package:Deal_Connect/components/loading.dart';
import 'package:Deal_Connect/components/no_items.dart';
import 'package:Deal_Connect/model/group_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileGroupIndex extends StatefulWidget {
  const ProfileGroupIndex({super.key});

  @override
  State<ProfileGroupIndex> createState() => _ProfileGroupIndexState();
}

class _ProfileGroupIndexState extends State<ProfileGroupIndex> {
  List<GroupUser>? groupUserList = [];
  bool _isLoading = true;
  int? userId;
  var args;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() {
    final widgetsBinding = WidgetsBinding.instance;
    widgetsBinding?.addPostFrameCallback((callback) async {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        setState(() {
          args = ModalRoute.of(context)?.settings.arguments;
        });

        if (args != null) {
          setState(() {
            userId = args['userId'];
          });
        }

        if (userId != null) {
          var response = await getMyGroups(queryMap: {'user_id': userId});
          if (response.status == 'success' && mounted) {
            Iterable iterable = response.data;
            List<GroupUser>? resData =
                List<GroupUser>.from(iterable.map((e) => GroupUser.fromJSON(e)));
            setState(() {
              groupUserList = resData;
              _isLoading = false;
            });
          }
        }
        setState(() {
          _isLoading = false;
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
    return DefaultLogoLayout(
        titleName: '소속 그룹',
        isNotInnerPadding: 'true',
        child: Column(
          children: [
            groupUserList != null && groupUserList!.isNotEmpty
                ? Expanded(
                    child: Container(
                    padding: EdgeInsets.all(13.0),
                    decoration: const BoxDecoration(
                      color: Color(0xFFf5f6f8),
                    ),
                    child: ListView.builder(
                      itemCount: groupUserList!.length,
                      itemBuilder: (context, index) {
                        GroupUser item = groupUserList![index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/group/info',
                                arguments: {'groupId': item.has_group!.id});
                          },
                          child: ListGroupCard(
                            item: item,
                          ),
                        );
                      },
                    ),
                                      ))
                : NoItems(),
          ],
        ));
  }
}
