import 'package:Deal_Connect/api/board.dart';
import 'package:Deal_Connect/api/group.dart';
import 'package:Deal_Connect/api/group_user.dart';
import 'package:Deal_Connect/components/alert/show_complete_dialog.dart';
import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/components/layout/default_next_layout.dart';
import 'package:Deal_Connect/components/list_card.dart';
import 'package:Deal_Connect/components/loading.dart';
import 'package:Deal_Connect/model/board_write.dart';
import 'package:Deal_Connect/model/group.dart';
import 'package:Deal_Connect/model/group_user.dart';
import 'package:Deal_Connect/pages/group/components/group_button.dart';
import 'package:Deal_Connect/pages/group/components/group_condition.dart';
import 'package:Deal_Connect/pages/group/components/group_board_list_card.dart';
import 'package:Deal_Connect/pages/group/group_board/group_board_info.dart';
import 'package:Deal_Connect/pages/group/group_manage/group_manage_index.dart';
import 'package:Deal_Connect/utils/custom_dialog.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

import 'components/group_data.dart';

class GroupView extends StatefulWidget {
  const GroupView({Key? key}) : super(key: key);

  @override
  State<GroupView> createState() => _GroupViewState();
}

class _GroupViewState extends State<GroupView> {
  int? groupId;
  Group? groupData;
  GroupUser? myGroupUser;
  List<BoardWrite>? groupBoardWriteLatest;
  bool _isLoading = true;

  var args;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() async {
    final widgetsBinding = WidgetsBinding.instance;
    widgetsBinding?.addPostFrameCallback((callback) async {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        setState(() {
          args = ModalRoute.of(context)?.settings.arguments;
        });

        if (args != null) {
          setState(() {
            groupId = args['groupId'];
          });
        }

        if (groupId != null) {
          await getGroup(groupId!).then((response) {
            if (response.status == 'success') {
              Group resultData = Group.fromJSON(response.data);
              setState(() {
                groupData = resultData;
              });
            } else {
              Fluttertoast.showToast(
                  msg: '그룹 정보를 받아오는 도중 오류가 발생했습니다.\n오류코드: 463');
            }
          });

          _initMyGroupUser(groupId!);
          _initGroupBoardWriteLatest(groupId!);
        }
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  void _initGroupBoardWriteLatest(groupId) async {
    await getBoardWriteLatestData(groupId).then((response) {
      if (response.status == 'success') {
        Iterable iterable = response.data;

        List<BoardWrite>? groupBoardWriteLatest =
            List<BoardWrite>.from(iterable.map((e) => BoardWrite.fromJSON(e)));

        setState(() {
          if (groupBoardWriteLatest != null) {
            this.groupBoardWriteLatest = groupBoardWriteLatest;
          }
        });
      }
    });
  }

  void _initMyGroupUser(groupId) async {
    await getGroupUser(queryMap: {
      'group_id': groupId,
    }).then((response) {
      if (response.status == 'success') {
        GroupUser myGroupUser = GroupUser.fromJSON(response.data);
        setState(() {
          if (myGroupUser != null) {
            this.myGroupUser = myGroupUser;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider groupMainImage;
    if (groupData != null && groupData!.has_group_image != null) {
      groupMainImage = CachedNetworkImageProvider(
        Utils.getImageFilePath(groupData!.has_group_image!),
      );
    } else {
      groupMainImage = AssetImage('assets/images/no-image.png');
    }

    if (_isLoading) {
      // 로딩 중 인디케이터 표시
      return Loading();
    }
    return DefaultNextLayout(
      titleName: groupData != null ? groupData!.name : '',
      isProcessable: groupData?.is_member == false ? true : false,
      bottomBar: true,
      isCancel: false,
      isNext: groupData?.is_member == true
          ? !(myGroupUser?.is_approved ?? false)
          : true,
      rightMoreBtn: (groupData!.is_leader != null && groupData!.is_leader == true) ? true : false,
      prevTitle: '취소',
      nextTitle: myGroupUser?.is_approved == false ? '승인 대기중' : '그룹 가입 신청하기',
      isNotInnerPadding: 'true',
      prevOnPressed: () {},
      nextOnPressed: () {
        if (groupData?.is_member == false) {
          _submit();
        }
      },
      rightMoreBtnAction: () {
        if (groupData != null) {
          if (groupData!.is_leader != null && groupData!.is_leader == true) {
            Navigator.pushNamed(context, '/group/manage', arguments: { "groupId": groupId, "groupName": groupData?.name });
          }
        }
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
                      image: groupMainImage,
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
                      groupData != null ? groupData!.name : '',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24.0),
                    if (groupData != null)
                      GroupCondition(
                          groupName: groupData != null ? groupData!.name : '',
                          groupId: groupData != null ? groupData!.id : 0,
                          partner: groupData != null
                              ? groupData!.users_count ?? 0
                              : 0,
                          history: groupData != null
                              ? groupData!.price_sum ?? 0
                              : 0),
                    const SizedBox(height: 24.0),
                    Row(
                      children: [
                        _reanderButton(
                          btnName: '글쓰기',
                          onPressed: () {
                            Navigator.pushNamed(context, '/group/board/create',
                                arguments: {
                                  'groupId': groupId,
                                  'groupName': groupData!.name
                                }).then((value) {
                              _initData();
                            });
                          },
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        _iconButton(
                          btnIcons: Icons.person_add,
                          onPressed: () {
                            showModalBottomSheet(
                                backgroundColor: Colors.white,
                                showDragHandle: false,
                                context: context,
                                builder: (_) {
                                  return Container(
                                    width: double.infinity,
                                    height: 90,
                                    padding: EdgeInsets.only(top: 20.0),
                                    color: HexColor("FFFFFF"),
                                    child: const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Spacer(),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.messenger),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text("문자")
                                                ],
                                              ),
                                              Spacer(),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.messenger),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text("카카오")
                                                ],
                                              ),
                                              Spacer(),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.messenger),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text("뭐시기")
                                                ],
                                              ),
                                              Spacer(),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.messenger),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text("문자")
                                                ],
                                              ),
                                              Spacer(),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                        ),
                      ],
                    ),
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
              child: groupBoardWriteLatest != null
                  ? Expanded(
                      child: Container(
                        decoration: BoxDecoration(color: Color(0xFFf5f6f8)),
                        child: ListView.builder(
                            padding: const EdgeInsets.only(
                              top: 14.0,
                              left: 14.0,
                              right: 14.0,
                            ),
                            itemCount: groupBoardWriteLatest!.length,
                            itemBuilder: (context, index) {
                              BoardWrite item = groupBoardWriteLatest![index];
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/group/board/info',
                                        arguments: {
                                          'boardWriteId': item.id,
                                          'groupName': groupData!.name
                                        }).then((value) {
                                      _initData();
                                    });
                                  },
                                  child: GroupBoardListCard(item: item));
                            }),
                      ),
                    )
                  : Text('등록된 글이 없습니다'),
            )
          ],
        ),
      ),
    );
  }

  _submit() async {
    CustomDialog.showProgressDialog(context);

    storeGroupUser({
      'group_id': groupId,
    }).then((response) async {
      CustomDialog.dismissProgressDialog();

      if (response.status == 'success') {
        _showCompleteDialog(context);
      } else {
        CustomDialog.showServerValidatorErrorMsg(response);
      }
    });
  }

  void _showCompleteDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ShowCompleteDialog(
          messageTitle: '가입 신청 완료',
          messageText: '가입 신청이 완료 되었습니다.',
          buttonText: '확인',
          onConfirmed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}

class _reanderButton extends StatelessWidget {
  final String btnName;
  final VoidCallback onPressed;

  const _reanderButton({
    required this.btnName,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          btnName,
          style: TextStyle(
              color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w500),
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 50),
          backgroundColor: Color(0xFFF5F6FA),
          foregroundColor: Color(0xFFF5F6FA),
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
      ),
    );
  }
}

class _iconButton extends StatelessWidget {
  final IconData btnIcons;
  final VoidCallback onPressed;

  const _iconButton({
    required this.btnIcons,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Icon(
          size: 20.0,
          btnIcons,
          color: Colors.black87,
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(0),
          minimumSize: Size(double.infinity, 50),
          backgroundColor: Color(0xFFF5F6FA),
          foregroundColor: Color(0xFFF5F6FA),
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
      ),
    );
  }
}
