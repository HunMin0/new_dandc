import 'package:Deal_Connect/api/business.dart';
import 'package:Deal_Connect/api/partner.dart';
import 'package:Deal_Connect/components/alert/show_complete_dialog.dart';
import 'package:Deal_Connect/components/common_item/grey_chip.dart';
import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/components/list_line_business_card.dart';
import 'package:Deal_Connect/components/list_row_business_card.dart';
import 'package:Deal_Connect/components/loading.dart';
import 'package:Deal_Connect/components/no_items.dart';
import 'package:Deal_Connect/db/company_data.dart';
import 'package:Deal_Connect/model/partner.dart';
import 'package:Deal_Connect/model/partnership.dart';
import 'package:Deal_Connect/model/user.dart';
import 'package:Deal_Connect/model/user_business.dart';
import 'package:Deal_Connect/model/user_keyword.dart';
import 'package:Deal_Connect/pages/business/business_detail/business_detail_info.dart';
import 'package:Deal_Connect/pages/profile/components/tab_list/not_user_registered.dart';
import 'package:Deal_Connect/utils/custom_dialog.dart';
import 'package:Deal_Connect/utils/shared_pref_utils.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

// 프로필
class OtherProfileIndex extends StatefulWidget {
  const OtherProfileIndex({Key? key}) : super(key: key);

  @override
  State<OtherProfileIndex> createState() => _OtherProfileIndexState();
}

class _OtherProfileIndexState extends State<OtherProfileIndex> {
  bool _isLoading = true;
  bool _isMine = false;
  String _isPartner = 'N';
  User? partnerUser;
  int? userId;
  User? myUser; // 저장 된 내 정보
  List<UserBusiness> userBusinessList = [];
  var profileData;
  Partnership? myPartnership;

  var args;

  @override
  void initState() {
    _initMyUser();
    _initData();
    super.initState();
    // tab컨트롤러 초기화
  }

  void _initMyUser() {
    SharedPrefUtils.getUser().then((value) => myUser = value);
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
            userId = args['userId'];
          });
        }
        if (userId != null) {
          await getPartnerUser(userId!).then((response) {
            if (response.status == 'success') {
              User resultData = User.fromJSON(response.data);
              setState(() {
                partnerUser = resultData;
                if (myUser!.id == partnerUser!.id) {
                  _isMine = true;
                }
              });

              _initUserProfileData(partnerUser!.id);
              _initUserBusinessData(partnerUser!.id);
              _initPartnerShip(partnerUser!.id);
            } else {
              Fluttertoast.showToast(
                  msg: '파트너 정보를 받아오는 도중 오류가 발생했습니다.\n오류코드: 463');
            }
          });
        }
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  void _initUserProfileData(int id) {
    getPartnerProfileData(id).then((response) {
      if (response.status == 'success') {
        var responseMyPageData = response.data;

        setState(() {
          if (responseMyPageData != null) {
            profileData = responseMyPageData;
          }
        });
      }
    });
  }

  void _initUserBusinessData(int id) {
    getUserBusinesses(queryMap: {'user_id': id}).then((response) {
      if (response.status == 'success') {
        Iterable iterable = response.data;

        List<UserBusiness>? userBusiness = List<UserBusiness>.from(
            iterable.map((e) => UserBusiness.fromJSON(e)));

        setState(() {
          this.userBusinessList = userBusiness;
        });
      }
    });
  }

  void _initPartnerShip(userId) async {
    await getPartnership(userId).then((response) {
      if (response.status == 'success') {
        Partnership myPartnershipData = Partnership.fromJSON(response.data);
        setState(() {
          this.myPartnership = myPartnershipData;
          if (myPartnership != null && myPartnership!.is_partner) {
            //승인
            if (myPartnership!.partnership_status == true) {
              _isPartner = 'Y';
            } else {
              //승인대기
              _isPartner = 'R';
            }
          } else {
            _isPartner = 'N';
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider? backgroundImage;
    if (partnerUser != null &&
        partnerUser?.has_user_profile != null &&
        partnerUser?.has_user_profile?.has_profile_image != null) {
      backgroundImage = CachedNetworkImageProvider(
        Utils.getImageFilePath(
            partnerUser!.has_user_profile!.has_profile_image!),
      );
    } else {
      backgroundImage = AssetImage('assets/images/no-image.png');
    }

    if (_isLoading) {
      return Loading();
    }
    return DefaultLogoLayout(
      titleName: "프로필 상세",
      isNotInnerPadding: "true",
      rightShareBtn: true,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: false,
              automaticallyImplyLeading: false,
              expandedHeight: 240.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 34.0,
                            backgroundImage: backgroundImage,
                          ),
                          SizedBox(
                            width: 18.0,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  partnerUser?.name ?? '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                if (partnerUser != null)
                                  if (partnerUser!.has_keywords != null)
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: _buildTags(
                                          partnerUser!.has_keywords!),
                                    )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, '/profile/partners');
                              },
                              child: _buildUserTab(
                                profileData?['partner_count'].toString() ?? '0',
                                '파트너',
                              ),
                            ),
                            _buildTabLine(),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/profile/groups');
                              },
                              child: _buildUserTab(
                                profileData?['group_count'].toString() ?? '0',
                                '소속그룹',
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      Row(
                        children: [
                          if (_isMine == false)
                            if (_isPartner == 'Y')
                              _reanderButton(
                                btnName: '전화',
                                onPressed: () {},
                              )
                            else if (_isPartner == 'N')
                              _reanderButton(
                                btnName: '파트너 신청',
                                onPressed: () {
                                  _attendPartner();
                                },
                              )
                            else if (_isPartner == 'R')
                              _reanderButton(
                                btnName: '승인 대기중',
                                onPressed: () {},
                              )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Divider(
                color: Color(0xFFF5F6FA),
                thickness: 10.0,
              ),
            ),
          ];
        },
        body: Container(
          color: Color(0xFFf5f6f8),
          padding: EdgeInsets.symmetric(horizontal: 14.0),
          child: userBusinessList != null && userBusinessList.isNotEmpty
              ? CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        UserBusiness item = userBusinessList[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/business/info',
                                arguments: {"userBusinessId": item.id});
                          },
                          child: ListRowBusinessCard(
                            item: item,
                          ),
                        );
                      }, childCount: userBusinessList.length),
                    ),
                  ],
                )
              : NoItems(),
        ),
      ),
    );
  }

  // 반복태그
  Widget _buildTags(List<UserKeyword> tagList) {
    List<Widget> tagWidgets = [];
    for (int i = 0; i < tagList.length; i++) {
      // 최대 3개 태그만 표시
      tagWidgets.add(Padding(
        padding: const EdgeInsets.only(right: 5.0),
        child: GreyChip(chipText: "#" + tagList[i].keyword),
      ));
    }

    return Row(children: tagWidgets);
  }

  void _attendPartner() {
    CustomDialog.showDoubleBtnDialog(
        context: context,
        msg: '${partnerUser!.name}님에게 파트너 신청을 하시겠습니까?',
        rightBtnText: '신청하기',
        onLeftBtnClick: () {},
        onRightBtnClick: () {
          _attendSubmit();
        });
  }

  void _attendSubmit() {
    CustomDialog.showProgressDialog(context);

    attendPartner({'partner_user_id': partnerUser!.id}).then((response) async {
      CustomDialog.dismissProgressDialog();

      if (response.status == 'success') {
        _showCompleteDialog(context, '파트너 신청', '파트너 신청이 완료되었습니다.');
      } else {
        CustomDialog.showServerValidatorErrorMsg(response);
      }
    });
  }

  void _showCompleteDialog(BuildContext context, title, text) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ShowCompleteDialog(
          messageTitle: title,
          messageText: text,
          buttonText: '확인',
          onConfirmed: () {
            _initData();
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
