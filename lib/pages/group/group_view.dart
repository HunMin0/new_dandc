import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/components/layout/default_next_layout.dart';
import 'package:Deal_Connect/components/list_card.dart';
import 'package:Deal_Connect/pages/group/components/group_button.dart';
import 'package:Deal_Connect/pages/group/components/group_condition.dart';
import 'package:Deal_Connect/pages/group/components/group_board_list_card.dart';
import 'package:Deal_Connect/pages/group/group_board/group_board_info.dart';
import 'package:Deal_Connect/pages/group/group_manage/group_manage_index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/group_data.dart';

class GroupView extends StatefulWidget {
  const GroupView({Key? key}) : super(key: key);

  @override
  State<GroupView> createState() => _GroupViewState();
}

class _GroupViewState extends State<GroupView> {
  String? group_id;

  var args;

  @override
  void initState() {
    super.initState();

    final widgetsBinding = WidgetsBinding.instance;
    widgetsBinding?.addPostFrameCallback((callback) {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        args = ModalRoute.of(context)?.settings.arguments;

        if (args != null) {
          setState(() {
            group_id = args['group_id'];
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultNextLayout(
        titleName: '서초구 고기집 사장모임',
        isProcessable: true,
        bottomBar: true,
        isCancel: false,
        rightMoreBtn: true,
        prevTitle: '취소',
        nextTitle: '그룹 가입 신청하기',
        isNotInnerPadding: 'true',
        prevOnPressed: () {},
        nextOnPressed: () {},
        rightMoreBtnAction: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => GroupManageIndex()));
        },
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverList(
                  delegate: SliverChildListDelegate([
                AspectRatio(
                  aspectRatio: 1.8 / 1,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/sample/main_sample01.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '서초구 고기집 사장모임',
                        style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 24.0),
                      GroupCondition(partner: 192, history: '10k'),
                      SizedBox(height: 24.0),
                      GroupButton(),
                    ],
                  ),
                ),
              ]))
            ];
          },
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Expanded(
                  child: Container(
                    decoration: BoxDecoration(color: Color(0xFFf5f6f8)),
                    child: ListView.builder(
                      padding: const EdgeInsets.only(
                        top: 14.0,
                        left: 14.0,
                        right: 14.0,
                      ),
                      itemCount: groupDataList.length,
                      itemBuilder: (context, index) {
                          Map<String, dynamic> groupData = groupDataList[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(builder: (context) => GroupBoardInfo(
                                      id: groupData['id'],
                                    )
                                  ),
                              );
                            },
                            child: GroupBoardListCard(
                              memThumbImagePath: groupData['memThumbImagePath'],
                              memNickName: groupData['memNickName'],
                              writeRegDate: groupData['writeRegDate'],
                              writeText: groupData['writeText'],
                              writeThumbImagePath: groupData['writeThumbImagePath'],
                              writeOutLinkPath: groupData['writeOutLinkPath'],
                              writeViewCnt: groupData['writeViewCnt'],
                            ),
                          );
                      }),
                    ),
                ),
              )
            ],
          ),
        ),
    );

  }
}
