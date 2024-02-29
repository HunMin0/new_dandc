import 'package:Deal_Connect/api/user_business_service.dart';
import 'package:Deal_Connect/components/alert/show_complete_dialog.dart';
import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/components/layout/default_next_layout.dart';
import 'package:Deal_Connect/components/loading.dart';
import 'package:Deal_Connect/model/user.dart';
import 'package:Deal_Connect/model/user_business_service.dart';
import 'package:Deal_Connect/utils/custom_dialog.dart';
import 'package:Deal_Connect/utils/shared_pref_utils.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

class BusinessServiceInfo extends StatefulWidget {
  const BusinessServiceInfo({super.key});

  @override
  State<BusinessServiceInfo> createState() => _BusinessServiceInfoState();
}

class _BusinessServiceInfoState extends State<BusinessServiceInfo> {
  int? businessServiceId;
  String? storeName;
  UserBusinessService? userBusinessService;
  bool _isLoading = true;
  bool _isManageable = false;
  User? myUser;

  var args;

  @override
  void initState() {
    _initMyUser();
    _initData();

    super.initState();
  }

  void _initMyUser() {
    SharedPrefUtils.getUser().then((value) => myUser = value);
  }

  void _initData() async {
    final widgetsBinding = WidgetsBinding.instance;
    widgetsBinding?.addPostFrameCallback((callback) async {
      if (ModalRoute
          .of(context)
          ?.settings
          .arguments != null) {
        setState(() {
          args = ModalRoute
              .of(context)
              ?.settings
              .arguments;
        });

        if (args != null) {
          setState(() {
            storeName = args['storeName'];
            businessServiceId = args['businessServiceId'];
          });
        }
        if (businessServiceId != null) {
          await getUserBusinessService(businessServiceId!).then((response) {
            if (response.status == 'success') {
              UserBusinessService resultData =
              UserBusinessService.fromJSON(response.data);
              setState(() {
                userBusinessService = resultData;
                if (myUser != null) {
                  if (myUser!.id == userBusinessService!.user_id) {
                    _isManageable = true;
                  }
                }
              });
            } else {
              Fluttertoast.showToast(
                  msg: '서비스 정보를 받아오는 도중 오류가 발생했습니다.\n오류코드: 463');
            }
          });
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

    ImageProvider serviceImage;

    if (userBusinessService != null && userBusinessService!.has_image != null) {
      serviceImage = CachedNetworkImageProvider(
        Utils.getImageFilePath(userBusinessService!.has_image!),
      );
    } else {
      serviceImage = AssetImage('assets/images/no-image.png');
    }

    return DefaultNextLayout(
      titleName: storeName ?? '',
      nextTitle: '수정',
      prevTitle: '삭제',
      isProcessable: true,
      bottomBar: _isManageable,
      nextOnPressed: () {
        Navigator.pushNamed(
            context, '/business/service/edit',
            arguments: {
              'userBusinessServiceId': userBusinessService!.id,
              'storeName': storeName
            }).then((value) {
          _initData();
        });
      },
      prevOnPressed: () {
        _deleteItem();
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(userBusinessService!.name != null
                ? userBusinessService!.name
                : '',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
            SizedBox(height: 10.0,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Image(
                    image: serviceImage,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 10,),
                Text(userBusinessService!.description)
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _deleteItem() {
    CustomDialog.showDoubleBtnDialog(context: context,
        msg: '정말 삭제하시겠습니까?',
        rightBtnText: '삭제',
        onLeftBtnClick: () {},
        onRightBtnClick: (){
          _deleteSubmit();
        });
  }

  void _deleteSubmit() {
    CustomDialog.showProgressDialog(context);

    deleteUserBusinessService(userBusinessService!.id).then((response) async {
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
          messageTitle: '삭제 완료',
          messageText: '삭제가 완료 되었습니다.',
          buttonText: '확인',
          onConfirmed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Navigator.popAndPushNamed(context, '/business/info', arguments: { "userBusinessId": userBusinessService!.user_business_id });
          },
        );
      },
    );
  }
}
