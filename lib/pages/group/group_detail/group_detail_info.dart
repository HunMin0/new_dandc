import 'package:Deal_Connect/api/board.dart';
import 'package:Deal_Connect/api/group.dart';
import 'package:Deal_Connect/api/group_user.dart';
import 'package:Deal_Connect/api/server_config.dart';
import 'package:Deal_Connect/components/alert/show_complete_dialog.dart';
import 'package:Deal_Connect/components/common_item/grey_chip.dart';
import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/components/image_viewer.dart';
import 'package:Deal_Connect/components/layout/sliver_layout.dart';
import 'package:Deal_Connect/components/loading.dart';
import 'package:Deal_Connect/components/no_items.dart';
import 'package:Deal_Connect/model/board_write.dart';
import 'package:Deal_Connect/model/group.dart';
import 'package:Deal_Connect/model/group_keyword.dart';
import 'package:Deal_Connect/model/group_user.dart';
import 'package:Deal_Connect/pages/group/components/group_condition.dart';
import 'package:Deal_Connect/pages/group/components/group_board_list_card.dart';
import 'package:Deal_Connect/utils/custom_dialog.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GroupDetailInfo extends StatefulWidget {
  const GroupDetailInfo({Key? key}) : super(key: key);

  @override
  State<GroupDetailInfo> createState() => _GroupDetailInfoState();
}

class _GroupDetailInfoState extends State<GroupDetailInfo> {
  int? groupId;
  Group? groupData;
  GroupUser? myGroupUser;
  List<BoardWrite>? groupBoardWriteLatest;
  bool _isLoading = true;
  bool _isManageable = false;
  String? shareUrl;

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
          generateAndSetUrl(groupId);
          await getGroup(groupId!).then((response) {
            if (response.status == 'success') {
              Group resultData = Group.fromJSON(response.data);
              setState(() {
                groupData = resultData;
                if (groupData!.is_leader != null &&
                    groupData!.is_leader == true) {
                  _isManageable = true;
                }
              });
            } else {
              Fluttertoast.showToast(
                  msg: '그룹 정보를 받아오는 도중 오류가 발생했습니다.\n오류코드: 463');
            }
          });

          await _initMyGroupUser(groupId!);
          await _initGroupBoardWriteLatest(groupId!);
        }
        setState(() {
          _isLoading = false;
        });
      }
    });
  }


  Future<void> generateAndSetUrl(id) async {
    setState(() {
      shareUrl = ServerConfig.SERVER_URL + '?uri=group/info&groupId=' + id.toString();
    });
  }

  Future<void> _initGroupBoardWriteLatest(groupId) async {
    var response = await getBoardWriteLatestData(groupId);
    if (response.status == 'success' && mounted) {
      Iterable iterable = response.data;

      List<BoardWrite>? groupBoardWriteLatest =
          List<BoardWrite>.from(iterable.map((e) => BoardWrite.fromJSON(e)));

      setState(() {
        if (groupBoardWriteLatest != null) {
          this.groupBoardWriteLatest = groupBoardWriteLatest;
        }
      });
    }

  }

  Future<void> _initMyGroupUser(groupId) async {
    var response = await getGroupUser(queryMap: {'group_id': groupId,});
    if (response.status == 'success' && response.data != null && mounted) {
      GroupUser myGroupUser = GroupUser.fromJSON(response.data);
      setState(() {
        this.myGroupUser = myGroupUser;
      });
    }
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

    if (_isLoading || groupData == null) {
      // 로딩 중 인디케이터 표시
      return Loading();
    }

    String nextButtonTitle = '그룹가입 신청하기';
    if (groupData?.is_member != null && groupData?.is_member == true) {
      if (myGroupUser != null && myGroupUser!.is_approved == false) {
        nextButtonTitle = '승인 대기중';
        if (myGroupUser!.is_deleted == true) {
          nextButtonTitle = '방출된 회원입니다';
        }
      }
    }

    return SliverLayout(
      isNotInnerPadding: 'true',
      bottomBar: true,
      isCancel: false,
      isProcessable: groupData?.is_member == false,
      isNext: groupData?.is_member == true
          ? !(myGroupUser?.is_approved ?? false)
          : true,
      prevTitle: '취소',
      nextTitle: nextButtonTitle,
      prevOnPressed: () {},
      nextOnPressed: () {
        if (groupData?.is_member == false) {
          _submit();
        }
      },
      child: CustomScrollView(
          physics: AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          slivers: <Widget>[
            CupertinoSliverRefreshControl(
              onRefresh: () async {
                setState(() {
                  _isLoading = true;
                });
                _initData();
              },
            ),
            SliverAppBar(
                surfaceTintColor: Colors.white,
                leading: IconButton(
                  padding: EdgeInsets.all(10.0),
                  icon: const Icon(CupertinoIcons.back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        if (shareUrl != null)
                          CustomDialog.showShareDialog(
                              context, groupData!.name, shareUrl!);
                      },
                      icon: const Icon(CupertinoIcons.person_add)),
                  if (_isManageable)
                    Stack(
                      children: [
                        IconButton(
                            onPressed: () {
                              if (groupData!.is_leader != null &&
                                  groupData!.is_leader == true) {
                                Navigator.pushNamed(context, '/group/manage',
                                    arguments: {
                                      "groupId": groupId,
                                      "groupName": groupData?.name
                                    }).then((value) {
                                  _initData();
                                });
                              }
                            },
                            icon: const Icon(CupertinoIcons.gear_big)),
                        if (groupData!.un_approved_users_count! > 0)
                          Positioned(
                            left: 5, // 우측 여백
                            top: 5, // 상단 여백
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: Colors.red, // 뱃지 배경색
                                shape: BoxShape.circle, // 원형 뱃지
                              ),
                            ),
                          ),
                      ],
                    ),
                ],
                pinned: true,
                expandedHeight: 350.0,
                flexibleSpace: FlexibleSpaceBar(
                    background: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ImageViewer(imageProvider: groupMainImage)));
                  },
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: groupMainImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withOpacity(0.5),
                              Colors.transparent,
                              Colors.transparent
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ))),
            SliverToBoxAdapter(
                child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(groupData!.name, style: SettingStyle.TITLE_STYLE),
                  const SizedBox(height: 10.0),
                  if (groupData!.description != null)
                    Text(groupData!.description ?? '',
                        style: SettingStyle.SUB_GREY_TEXT),
                  const SizedBox(height: 10.0),
                  if (groupData!.has_keywords != null)
                    _buildTags(groupData!.has_keywords!),
                  const SizedBox(height: 24.0),
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (myGroupUser!.is_approved == true)
                              Navigator.pushNamed(context, '/group/partner',
                                  arguments: {
                                    'groupId': groupId,
                                    'groupName': groupData!.name
                                  });
                          },
                          child: _buildUserTab(
                            groupData!.approved_users_count.toString() ?? '0',
                            '파트너',
                          ),
                        ),
                        _buildTabLine(),
                        GestureDetector(
                          onTap: () {
                            if (myGroupUser!.is_approved == true)
                              Navigator.pushNamed(context, '/group/trade',
                                  arguments: {
                                    'groupId': groupId,
                                    'groupName': groupData!.name
                                  });
                          },
                          child: _buildUserTab(
                            Utils.moneyGenerator(groupData!.price_sum ?? 0),
                            '거래내역',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  if (_isManageable == true)
                    Row(
                      children: [
                        _reanderButton(
                          btnName: '\u{1F4AC} 글쓰기',
                          onPressed: () {
                            Navigator.pushNamed(
                                context, '/group/board/create', arguments: {
                              'groupId': groupId,
                              'groupName': groupData!.name
                            }).then((value) {
                              _initData();
                            });
                          },
                        ),
                      ],
                    ),
                ],
              ),
            )),
            if (myGroupUser != null && myGroupUser!.is_approved == true)
              (groupBoardWriteLatest?.isEmpty ?? true)
                  ? SliverToBoxAdapter(
                      child: NoItems(), // 데이터가 없을 때 적절한 위젯을 반환합니다.
                    )
                  : SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            BoardWrite item = groupBoardWriteLatest![index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/group/board/info',
                                  arguments: {
                                    'boardWriteId': item.id,
                                    'groupName': groupData!.name,
                                  },
                                ).then((value) {
                                  _initData();
                                });
                              },
                              child: GroupBoardListCard(item: item),
                            );
                          },
                          childCount: groupBoardWriteLatest!.length,
                        ),
                      )),
            SliverToBoxAdapter(
              child: Container(
                height: 350, // SliverAppBar와 같은 높이의 공간을 추가
                color: Colors.transparent, // 필요에 따라 색상 지정
              ),
            ),
          ]),
    );
  }

  _submit() async {
    CustomDialog.showDoubleBtnDialog(
        context: context,
        msg: '가입 신청 하시겠습니까?',
        rightBtnText: '신청',
        onLeftBtnClick: () {},
        onRightBtnClick: () {
          _joinSubmit();
        });
  }

  _joinSubmit() async {
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

// 반복태그
  Widget _buildTags(List<GroupKeyword> tagList) {
    List<Widget> tagWidgets = [];
    for (int i = 0; i < tagList.length; i++) {
      if (i < 3) {
        tagWidgets.add(Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: GreyChip(
            chipText: '#' + tagList[i].keyword,
          ),
        ));
      } else {
        break;
      }
    }
    return Row(children: tagWidgets);
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

  @override
  void dispose() {
    super.dispose();
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
