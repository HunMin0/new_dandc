import 'dart:io';

import 'package:Deal_Connect/api/business.dart';
import 'package:Deal_Connect/components/alert/show_complete_dialog.dart';
import 'package:Deal_Connect/components/const/setting_colors.dart';
import 'package:Deal_Connect/components/layout/default_next_layout.dart';
import 'package:Deal_Connect/components/loading.dart';
import 'package:Deal_Connect/model/user_business.dart';
import 'package:Deal_Connect/pages/profile/company_create/company_create_step_one.dart';
import 'package:Deal_Connect/utils/custom_dialog.dart';
import 'package:Deal_Connect/utils/shared_pref_utils.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class CompanyCreatePhoto extends StatefulWidget {
  const CompanyCreatePhoto({super.key});

  @override
  State<CompanyCreatePhoto> createState() => _CompanyCreatePhotoState();
}

class _CompanyCreatePhotoState extends State<CompanyCreatePhoto> {
  File? _pickedImage;
  bool isProcessable = false;
  bool checkState = false;
  bool _isLoading = true;
  int? userBusinessCategoryId;

  //수정시 사용
  int? userBusinessId;
  String? storeName;
  UserBusiness? userBusiness;

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
            userBusinessCategoryId = args['userBusinessCategoryId'];
            userBusinessId = args['userBusinessId'];
            storeName = args['storeName'];
          });
        }
        if (userBusinessId != null) {
          await getUserBusiness(userBusinessId!).then((response) {
            if (response.status == 'success') {
              UserBusiness resultData = UserBusiness.fromJSON(response.data);
              if (resultData != null) {
                setState(() {
                  userBusiness = resultData;
                });
              }
            } else {
              Fluttertoast.showToast(
                  msg: '업체 정보를 받아오는 도중 오류가 발생했습니다.\n오류코드: 463');
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
    final bottomTextStyle = TextStyle(
      color: Color(0xFF232323),
      fontSize: 14.0,
      //fontWeight: FontWeight.w600
    );

    ImageProvider businessMainImage;
    if (userBusiness != null && userBusiness!.has_business_image != null) {
      businessMainImage = CachedNetworkImageProvider(
        Utils.getImageFilePath(userBusiness!.has_business_image!),
      );
    } else {
      businessMainImage = AssetImage('assets/images/no-image.png');
    }

    if (_isLoading) {
      return Loading();
    }

    return DefaultNextLayout(
      titleName: storeName ?? '업체등록',
      isProcessable: isProcessable,
      bottomBar: true,
      prevTitle: '취소',
      nextTitle: userBusinessId != null ? '저장' : '다음',
      prevOnPressed: () {
        if(userBusinessId != null) {
          Navigator.of(context).pop();
        } else {
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      },
      nextOnPressed: () {
        if(userBusinessId != null) {
          _submit();
        } else {
          Navigator.pushNamed(context, '/profile/company/create/step1',
              arguments: {
                'userBusinessCategoryId': userBusinessCategoryId,
                'imageFile': _pickedImage,
              });
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('사업장 대표사진을 등록해주세요',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              )),
          SizedBox(
            height: 40.0,
          ),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  backgroundColor: Colors.white,
                  showDragHandle: true,
                  context: context,
                  builder: (context) {
                    return SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: Text(
                                    '카메라로 촬영',
                                    style: bottomTextStyle,
                                  ),
                                ),
                                onTap: () {
                                  ImagePicker()
                                      .pickImage(source: ImageSource.camera)
                                      .then((xfile) {
                                    if (xfile != null) {
                                      setState(() {
                                        _pickedImage = File(xfile.path);
                                        isProcessable = true;
                                      });
                                    }
                                    Navigator.maybePop(context);
                                  });
                                },
                              ),
                              Divider(
                                height: 1.0,
                                color: Color(0xFFdddddd),
                              ),
                              GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: Text(
                                    '앨범에서 가져오기',
                                    style: bottomTextStyle,
                                  ),
                                ),
                                onTap: () {
                                  ImagePicker()
                                      .pickImage(source: ImageSource.gallery)
                                      .then((xfile) {
                                    if (xfile != null) {
                                      setState(() {
                                        _pickedImage = File(xfile.path);
                                        isProcessable = true;
                                      });
                                    }
                                    Navigator.maybePop(context);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            },
            child: _pickedImage == null
                ? (userBusiness != null &&
                        userBusiness!.has_business_image != null)
                    ? Container(
                        width: double.infinity,
                        height: 240.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(image: businessMainImage, fit: BoxFit.cover),
                        ),
                      )
                    : Container(
                        width: double.infinity,
                        height: 240.0,
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt,
                              color: Color(0xFFD9D9D9),
                              size: 60.0,
                            ),
                            Text(
                              '대표사진을 등록 해주세요',
                              style: TextStyle(color: Color(0xFFA2A2A2)),
                            ),
                          ],
                        ),
                      )
                : Container(
                    width: double.infinity,
                    height: 240.0,
                    child: Image.file(
                      _pickedImage!,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
          SizedBox(
            height: 20.0,
          ),
          if (_pickedImage == null)
          Row(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(20.0),
                onTap: () {
                  setState(() {
                    checkState = !checkState;
                    if (!checkState) {
                      checkState = false;
                    }
                    isProcessable = checkState || (_pickedImage != null);
                  });
                },
                child: _checkType(checkState: checkState),
              ),
              SizedBox(
                width: 10.0,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    checkState = !checkState;
                    if (!checkState) {
                      checkState = false;
                    }
                    isProcessable = checkState || (_pickedImage != null);
                  });
                },
                child: _notImage(
                  underText: '대표사진 다음에 등록하기',
                  checkState: checkState,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _submit() async {
    CustomDialog.showProgressDialog(context);

    updateUserBusiness(userBusiness!.id, {
      'name': userBusiness!.name,
      'phone': userBusiness!.phone,
    }, _pickedImage).then((response) async {
      CustomDialog.dismissProgressDialog();

      if (response.status == 'success') {
        UserBusiness userBusiness = UserBusiness.fromJSON(response.data);

        if (userBusiness.has_owner != null) {
          await SharedPrefUtils.setUser(userBusiness.has_owner!);
        }
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
          messageTitle: '수정완료',
          messageText: '수정이 완료되었습니다.',
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

class _notImage extends StatelessWidget {
  final bool checkState;
  final String underText;

  const _notImage({
    required this.underText,
    required this.checkState,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      underText,
      style: TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.w500,
        color: checkState ? Color(0xFF75A8E4) : Colors.grey,
      ),
    );
  }
}

class _checkType extends StatelessWidget {
  const _checkType({
    Key? key,
    required this.checkState,
  }) : super(key: key);

  final bool checkState;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 26,
      height: 26,
      padding: EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
            color: checkState ? PRIMARY_COLOR : Color(0xFFDDDDDD), width: 2.0),
        color: checkState ? PRIMARY_COLOR : Colors.transparent, // 클릭 시 배경색 변경
      ),
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Icon(
          Icons.check,
          size: 16.0,
          color: checkState ? Colors.white : Color(0xFFDDDDDD),
        ),
      ),
    );
  }
}
