import 'package:Deal_Connect/api/group_user.dart';
import 'package:Deal_Connect/components/alert/show_complete_dialog.dart';
import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/components/list_partner_card.dart';
import 'package:Deal_Connect/components/list_partner_manage_card.dart';
import 'package:Deal_Connect/components/loading.dart';
import 'package:Deal_Connect/components/no_items.dart';
import 'package:Deal_Connect/db/vertical_data.dart';
import 'package:Deal_Connect/model/group_user.dart';
import 'package:Deal_Connect/model/user.dart';
import 'package:Deal_Connect/utils/custom_dialog.dart';
import 'package:Deal_Connect/utils/shared_pref_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

class GroupManagePartner extends StatefulWidget {
  const GroupManagePartner({super.key});

  @override
  State<GroupManagePartner> createState() => _GroupManagePartnerState();
}

class _GroupManagePartnerState extends State<GroupManagePartner>
    with TickerProviderStateMixin {
  late final TabController tabController;
  int? groupId;
  String? groupName;
  List<GroupUser> groupUserList = [];
  bool _isLoading = true;
  User? myUser;

  var args;

  @override
  void initState() {
    super.initState();
    final widgetsBinding = WidgetsBinding.instance;
    widgetsBinding?.addPostFrameCallback((callback) async {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        setState(() {
          args = ModalRoute.of(context)?.settings.arguments;
        });

        if (args != null) {
          setState(() {
            groupId = args['groupId'];
            groupName = args['groupName'];
          });
        }
      }
      _initData();
      _initMyUser();
    });

    tabController = TabController(
      length: 2,
      vsync: this,
    );
    tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    tabController.removeListener(_handleTabSelection);
    tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (tabController.indexIsChanging) {
      _initData();
    }
  }

  void _initData() async {
    setState(() {
      _isLoading = true; // 데이터 로딩 시작
    });

    bool? isApproved =
        tabController.index == 0 ? null : true; // 탭 인덱스에 따라 조건 변경

    if (groupId != null) {
      await getGroupUsers(queryMap: {
        'group_id': groupId,
        'is_approved': isApproved,
      }).then((response) {
        if (response.status == 'success') {
          Iterable iterable = response.data;
          List<GroupUser> dataList =
              List<GroupUser>.from(iterable.map((e) => GroupUser.fromJSON(e)));
          setState(() {
            groupUserList = dataList;
          });
        } else {
          Fluttertoast.showToast(
              msg: '그룹유저 정보를 받아 오는 도중 오류가 발생했습니다.\n오류코드: 463');
        }
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _initMyUser() {
    SharedPrefUtils.getUser().then((value) => myUser = value);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      // 로딩 중 인디케이터 표시
      return Loading();
    }

    return DefaultLogoLayout(
        titleName: groupName,
        isNotInnerPadding: 'true',
        child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: false,
                  expandedHeight: 80,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: TextField(
                                  onSubmitted: (value) {
                                    print(value);
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: HexColor("#F5F6FA"),
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 20,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      // 테두리를 둥글게 설정
                                      borderSide:
                                          BorderSide.none, // 바텀 border 없애기
                                    ),
                                    prefixIcon: Icon(Icons.search_rounded),
                                    hintText: '검색 키워드를 입력해주세요',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Divider(
                    color: Color(0xFFF5F6FA),
                    thickness: 10.0,
                  ),
                ),
                SliverPersistentHeader(
                  delegate: GroupPartnerTabHeaderDelegate(tabController),
                  pinned: true,
                ),
                SliverToBoxAdapter(
                  child: Divider(
                    color: Color(0xFFF5F6FA),
                    thickness: 16.0,
                  ),
                ),
              ];
            },
            body: groupUserList != null && groupUserList.isNotEmpty
                ? Column(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          color: Color(0xFFF5F6FA),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFf5f6f8),
                            ),
                            child: ListView.builder(
                              itemCount: groupUserList.length,
                              itemBuilder: (context, index) {
                                GroupUser item = groupUserList[index];
                                return ListPartnerCard(
                                  item: item,
                                  isMine: myUser != null ? (item.user_id == myUser!.id ? true : false) : false,
                                  isManager: true,
                                  onApprovePressed: () {
                                    onManageButtonPressed(item, 'approve');
                                  },
                                  onDeclinePressed: () {
                                    onManageButtonPressed(item, 'decline');
                                  },
                                  onOutPressed: () {
                                    onManageButtonPressed(item, 'out');
                                  },
                                  onManagerPressed: () {
                                    onManageButtonPressed(item, 'manager');
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : NoItems()));
  }

  void onManageButtonPressed(GroupUser user, String division) {
    String rightBtnText = '승인';
    if (division == 'approve') {
      rightBtnText = '승인';
    } else if (division == 'decline') {
      rightBtnText = '반려';
    } else if (division == 'out') {
      rightBtnText = '방출';
    } else if (division == 'manager') {
      rightBtnText = '관리자로 승급';
    }

    CustomDialog.showDoubleBtnDialog(
        context: context,
        leftBtnText: '취소',
        rightBtnText: rightBtnText,
        msg: user.has_user!.name + ' 회원을 ' + rightBtnText + '하시겠습니까?',
        onLeftBtnClick: () {},
        onRightBtnClick: () {
          approveSubmit(user, division);
        },
    );
  }

  void approveSubmit(GroupUser user, String division) {
    CustomDialog.showProgressDialog(context);
    manageGroupUser({
      'group_user_id': user.id,
      'division': division,
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
          messageTitle: '처리 완료',
          messageText: '처리 되었습니다.',
          buttonText: '확인',
          onConfirmed: () {
            Navigator.of(context).pop();
            _initData();
          },
        );
      },
    );
  }
}

class GroupPartnerTabHeaderDelegate extends SliverPersistentHeaderDelegate {
  final TabController tabController;

  GroupPartnerTabHeaderDelegate(this.tabController);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 50.0,
      color: Colors.white,
      child: TabBar(
        controller: tabController,
        indicatorColor: Colors.black,
        indicatorWeight: 2.0,
        labelColor: Colors.black,
        dividerColor: Colors.white,
        unselectedLabelColor: Colors.grey[500],
        labelStyle: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w500,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: [
          Tab(
            child: Text(
              '신규가입요청',
            ),
          ),
          Tab(
            child: Text(
              '기존회원',
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 50.0;

  @override
  double get minExtent => 50.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
