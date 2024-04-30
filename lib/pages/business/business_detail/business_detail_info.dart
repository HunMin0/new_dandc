import 'package:Deal_Connect/api/business.dart';
import 'package:Deal_Connect/api/partner.dart';
import 'package:Deal_Connect/api/server_config.dart';
import 'package:Deal_Connect/api/user_business_service.dart';
import 'package:Deal_Connect/components/alert/show_complete_dialog.dart';
import 'package:Deal_Connect/components/common_item/grey_chip.dart';
import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/components/image_viewer.dart';
import 'package:Deal_Connect/components/layout/sliver_layout.dart';
import 'package:Deal_Connect/components/list_service_card.dart';
import 'package:Deal_Connect/components/loading.dart';
import 'package:Deal_Connect/components/no_items.dart';
import 'package:Deal_Connect/model/partnership.dart';
import 'package:Deal_Connect/model/user.dart';
import 'package:Deal_Connect/model/user_business.dart';
import 'package:Deal_Connect/model/user_business_keyword.dart';
import 'package:Deal_Connect/model/user_business_service.dart';
import 'package:Deal_Connect/utils/custom_dialog.dart';
import 'package:Deal_Connect/utils/shared_pref_utils.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';

class BusinessDetailInfo extends StatefulWidget {
  const BusinessDetailInfo({super.key});

  @override
  State<BusinessDetailInfo> createState() => _BusinessDetailInfoState();
}

class _BusinessDetailInfoState extends State<BusinessDetailInfo> {
  int? userBusinessId;
  UserBusiness? userBusiness;
  List<UserBusinessService>? userBusinessServiceList;
  bool _isLoading = true;
  bool _isManageable = false;
  String _isPartner = 'N'; // 'N' 아님, 'R' 승인대기, 'Y' 파트너
  User? myUser;
  Partnership? myPartnership;
  String? shareUrl;

  var args;

  @override
  void initState() {
    _initMyUser();
    _initData();
    super.initState();
  }

  Future<void> generateAndSetUrl(id) async {
    setState(() {
      shareUrl = ServerConfig.SERVER_URL + '?uri=business/info&userBusinessId=' + id.toString();
    });
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
            userBusinessId = args['userBusinessId'];
          });
        }
        if (userBusinessId != null) {
          generateAndSetUrl(userBusinessId);
          await getUserBusiness(userBusinessId!).then((response) async {
            if (response.status == 'success') {
              UserBusiness resultData = UserBusiness.fromJSON(response.data);
              setState(() {
                if (resultData != null) {
                  userBusiness = resultData;
                  if (myUser != null) {
                    if (myUser!.id == userBusiness!.user_id) {
                      _isManageable = true;
                    }
                  }
                }
              });

              if (userBusiness?.user_id != null) {
                await _initPartnerShip(userBusiness!.user_id);
              }
            } else {
              Fluttertoast.showToast(
                  msg: '업체 정보를 받아오는 도중 오류가 발생했습니다.\n오류코드: 463');
            }
          });

          await _initUserBusinessServices(userBusinessId);
        }
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  Future<void> _initUserBusinessServices(userBusinessId) async {
    var response = await getUserBusinessServices(queryMap: {'user_business_id': userBusinessId,});
    if (response.status == 'success' && mounted) {
      Iterable iterable = response.data;
      List<UserBusinessService>? userBusinessServiceList =
          List<UserBusinessService>.from(
              iterable.map((e) => UserBusinessService.fromJSON(e)));
      setState(() {
        this.userBusinessServiceList = userBusinessServiceList;
      });
    }
  }

  Future<void> _initPartnerShip(userId) async {
    var response = await getPartnership(userId);
    if (response.status == 'success' && mounted) {
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
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider businessMainImage;
    ImageProvider ownerAvatarImage;

    if (userBusiness != null && userBusiness!.has_business_image != null) {
      businessMainImage = CachedNetworkImageProvider(
        Utils.getImageFilePath(userBusiness!.has_business_image!),
      );
    } else {
      businessMainImage = const AssetImage('assets/images/no-image.png');
    }

    if (userBusiness != null &&
        userBusiness!.has_owner != null &&
        userBusiness!.has_owner!.profile != null &&
        userBusiness!.has_owner!.profile!.has_profile_image != null) {
      ownerAvatarImage = CachedNetworkImageProvider(
        Utils.getImageFilePath(
            userBusiness!.has_owner!.profile!.has_profile_image!),
      );
    } else {
      ownerAvatarImage = const AssetImage('assets/images/no-image.png');
    }

    if (_isLoading) {
      // 로딩 중 인디케이터 표시
      return const Loading();
    }
    return SliverLayout(
        isNotInnerPadding: 'true',
        child: CustomScrollView(
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
                padding: const EdgeInsets.all(10.0),
                icon: const Icon(CupertinoIcons.back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              actions: [
                if (shareUrl != null)
                IconButton(
                    onPressed: () {
                      CustomDialog.showShareDialog(context, '공유하기', shareUrl!);
                    },
                    icon: const Icon(CupertinoIcons.share)),
                if (_isManageable)
                  IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(0),
                            ),
                          ),
                          builder: (BuildContext bc) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 40.0),
                              child: SafeArea(
                                child: Wrap(
                                  children: <Widget>[
                                    if (userBusiness!.is_main == false)
                                      ListTile(
                                        title: Text(
                                          '대표업체등록',
                                          style: SettingStyle.SUB_TITLE_STYLE
                                              .copyWith(
                                              color:
                                              SettingStyle.MAIN_COLOR),
                                          textAlign: TextAlign.center,
                                        ),
                                        onTap: () {
                                          Navigator.pop(context);
                                          _mainItem();
                                        },
                                      ),
                                    Divider(
                                      height: 1,
                                      thickness: 1,
                                      color: HexColor('#dddddd'),
                                    ),
                                    ListTile(
                                      title: const Text(
                                        '수정하기',
                                        style: SettingStyle.SUB_TITLE_STYLE,
                                        textAlign: TextAlign.center,
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                        Navigator.pushNamed(
                                            context, '/business/edit',
                                            arguments: {
                                              'userBusinessId':
                                              userBusiness!.id,
                                              'storeName': userBusiness!.name
                                            }).then((value) {
                                          _initData();
                                        });
                                      },
                                    ),
                                    Divider(
                                      height: 1,
                                      thickness: 1,
                                      color: HexColor('#dddddd'),
                                    ),
                                    ListTile(
                                      title: Text(
                                        '삭제하기',
                                        style: SettingStyle.SUB_TITLE_STYLE
                                            .copyWith(color: Colors.red),
                                        textAlign: TextAlign.center,
                                      ),
                                      onTap: () {
                                        // 삭제 로직 처리
                                        Navigator.pop(context); // 하단 시트 닫기
                                        _deleteItem();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(CupertinoIcons.ellipsis_vertical)),
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
                                ImageViewer(imageProvider: businessMainImage)));
                  },
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: businessMainImage,
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
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                userBusiness != null ? userBusiness!.name : '',
                                style: SettingStyle.TITLE_STYLE,
                              ),
                            ),
                            Text(
                              userBusiness?.description ?? '',
                              style: TextStyle(
                                  fontSize: 16, color: HexColor("#5D5D5D")),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/profile/partner/info',
                                        arguments: {
                                          'userId': userBusiness!.has_owner!.id
                                        });
                                  },
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 15.0,
                                        backgroundImage: ownerAvatarImage,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        userBusiness != null
                                            ? userBusiness!.has_owner?.name ??
                                                ''
                                            : '',
                                        style: const TextStyle(fontSize: 16),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: 1,
                                  height: 20,
                                  color: HexColor("#222222"),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 25,
                                      child: const Image(
                                        image: AssetImage(
                                            'assets/images/icons/partner_icon.png'),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "파트너 " +
                                          (myPartnership != null
                                              ? myPartnership!.partners_count
                                                  .toString()
                                              : "0") +
                                          "명",
                                      style: const TextStyle(fontSize: 16),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            if (userBusiness != null &&
                                userBusiness!.has_keywords != null)
                              _buildTags(userBusiness!.has_keywords!),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(children: [
                              if (_isPartner == 'Y' ||
                                  _isManageable == true) ...[
                                _reanderButton(
                                  btnName: '\u{1F4DE} 전화',
                                  onPressed: () {
                                    launchUrl(Uri.parse(
                                        "tel:${userBusiness!.phone}"));
                                  },
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                if (_isManageable == false)
                                  _reanderButton(
                                    btnName: '\u{1F4B3} 구매등록',
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, '/trade/buy/create',
                                          arguments: {
                                            'userBusinessId': userBusiness!.id
                                          });
                                    },
                                  ),
                                if (_isManageable == true)
                                  _reanderButton(
                                    btnName: '\u{1F4CB} 판매내역',
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, '/business/history',
                                          arguments: {
                                            'userBusinessId': userBusiness!.id
                                          });
                                    },
                                  ),

                              ] else if (_isPartner == 'N')
                                _reanderButton(
                                  btnName: '\u{1F44B} 파트너 신청',
                                  onPressed: () {
                                    _attendPartner();
                                  },
                                )
                              else if (_isPartner == 'R')
                                _reanderButton(
                                  btnName: '\u{231B} 승인 대기중',
                                  onPressed: () {},
                                )
                            ]),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 10,
                        color: HexColor("#f5f6fa"),
                      ),
                      if (userBusiness != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          child: Column(
                            children: [
                              _iconText(
                                  Icons.place,
                                  (userBusiness!.address1 ?? '') +
                                      ' ' +
                                      (userBusiness!.address2 ?? '')),
                              if (userBusiness!.website != null)
                                _iconText(Icons.desktop_windows_rounded,
                                    userBusiness!.website ?? ''),
                              _iconText(Icons.watch_later,
                                  userBusiness!.work_time ?? ''),
                              if (userBusiness != null &&
                                  userBusiness!.has_weekend != null &&
                                  userBusiness!.has_weekend)
                                _iconText(Icons.next_week_outlined,
                                    userBusiness!.weekend ?? ''),
                              if (userBusiness != null &&
                                  userBusiness!.has_holiday != null &&
                                  userBusiness!.has_holiday)
                                _iconText(
                                    Icons.restore, userBusiness!.holiday ?? ''),
                              _iconText(Icons.phone, userBusiness!.phone ?? ''),
                            ],
                          ),
                        ),
                      Divider(
                        thickness: 10,
                        color: HexColor("#f5f6fa"),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          children: [
                            const Text(
                              "주요 서비스",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            if (_isManageable)
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, '/business/service/create',
                                      arguments: {
                                        'userBusinessId': userBusinessId
                                      }).then((value) {
                                    _initData();
                                  });
                                },
                                child: const Text(
                                  '추가하기',
                                  style: TextStyle(
                                    color: Color(0xff333333),
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFf5f6fa),
                                  foregroundColor: const Color(0xFFf5f6fa),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0)),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 10,
                        color: HexColor("#f5f6fa"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            (userBusinessServiceList?.isEmpty ?? true)
                ? const SliverToBoxAdapter(
                    child: NoItems(), // 데이터가 없을 때 적절한 위젯을 반환합니다.
                  )
                : SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // 한 줄에 2개의 아이템
                        crossAxisSpacing: 10.0, // 아이템 간의 가로 간격
                        mainAxisSpacing: 10.0, // 아이템 간의 세로 간격
                        childAspectRatio: 1.2 / 1, // 아이템의 가로세로 비율
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          // 여기에 각 그리드 항목을 빌드하는 로직을 추가합니다.
                          UserBusinessService item =
                              userBusinessServiceList![index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, '/business/service/info',
                                  arguments: {
                                    'businessServiceId': item.id,
                                    'storeName': userBusiness!.name,
                                  }).then((value) {
                                _initData();
                              });
                            },
                            child: ListServiceCard(
                                item: item, storeName: userBusiness!.name),
                          );
                        },
                        childCount: userBusinessServiceList?.length ??
                            0, // 그리드 항목의 수를 설정합니다.
                      ),
                    ),
                  ),
            SliverToBoxAdapter(
              child: Container(
                height: 350, // SliverAppBar와 같은 높이의 공간을 추가
                color: Colors.transparent, // 필요에 따라 색상 지정
              ),
            ),
          ],
        ));
  }

// 반복태그
  Widget _buildTags(List<UserBusinessKeyword> tagList) {
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

  Column _iconText(IconData prefixIcon, String text) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              prefixIcon,
              color: HexColor("#ABABAB"),
              size: 18,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(child: Text(text, overflow: TextOverflow.ellipsis,))
          ],
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }

  void _attendPartner() {
    CustomDialog.showDoubleBtnDialog(
        context: context,
        msg: '${userBusiness!.has_owner!.name}님에게 파트너 신청을 하시겠습니까?',
        rightBtnText: '신청하기',
        onLeftBtnClick: () {},
        onRightBtnClick: () {
          _attendSubmit();
        });
  }

  void _attendSubmit() {
    CustomDialog.showProgressDialog(context);

    attendPartner({'partner_user_id': userBusiness!.has_owner!.id})
        .then((response) async {
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

  void _deleteItem() {
    CustomDialog.showDoubleBtnDialog(
        context: context,
        msg: '정말 삭제하시겠습니까?',
        rightBtnText: '삭제',
        onLeftBtnClick: () {},
        onRightBtnClick: () {
          _deleteSubmit();
        });
  }

  void _deleteSubmit() {
    CustomDialog.showProgressDialog(context);

    deleteUserBusiness(userBusiness!.id).then((response) async {
      CustomDialog.dismissProgressDialog();

      if (response.status == 'success') {
        _showDeleteCompleteDialog(context, '업체 삭제', '삭제되었습니다.');
      } else {
        CustomDialog.showServerValidatorErrorMsg(response);
      }
    });
  }

  void _showDeleteCompleteDialog(BuildContext context, title, text) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ShowCompleteDialog(
          messageTitle: title,
          messageText: text,
          buttonText: '확인',
          onConfirmed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void _mainItem() {
    CustomDialog.showDoubleBtnDialog(
        context: context,
        msg: '대표 업체로 등록하시겠습니까?',
        rightBtnText: '등록',
        onLeftBtnClick: () {},
        onRightBtnClick: () {
          _mainSubmit();
        });
  }

  void _mainSubmit() {
    CustomDialog.showProgressDialog(context);

    updateMainUserBusiness(userBusiness!.id, {'is_main': true})
        .then((response) async {
      CustomDialog.dismissProgressDialog();

      if (response.status == 'success') {
        _showCompleteDialog(context, '대표 업체 등록', '등록되었습니다.');
      } else {
        CustomDialog.showServerValidatorErrorMsg(response);
      }
    });
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
          style: SettingStyle.NORMAL_TEXT_STYLE,
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          backgroundColor: const Color(0xFFF5F6FA),
          foregroundColor: const Color(0xFFF5F6FA),
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
      ),
    );
  }
}
