import 'dart:io';

import 'package:Deal_Connect/api/user_business_service.dart';
import 'package:Deal_Connect/components/alert/show_complete_dialog.dart';
import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/components/custom/join_text_form_field.dart';
import 'package:Deal_Connect/components/layout/default_next_layout.dart';
import 'package:Deal_Connect/model/user_business_service.dart';
import 'package:Deal_Connect/utils/custom_dialog.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class BusinessServiceCreate extends StatefulWidget {
  const BusinessServiceCreate({super.key});

  @override
  State<BusinessServiceCreate> createState() => _BusinessServiceCreateState();
}

class _BusinessServiceCreateState extends State<BusinessServiceCreate> {
  int? userBusinessId;
  int? userBusinessServiceId;
  String? storeName;
  UserBusinessService? userBusinessService;
  bool _isLoading = true;

  var args;

  File? _pickedImage;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    _initData();
    super.initState();
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
            userBusinessServiceId = args['userBusinessServiceId'];
            storeName = args['storeName'];
          });
        }
        if (userBusinessServiceId != null) {
          await getUserBusinessService(userBusinessServiceId!).then((response) {
            if (response.status == 'success') {
              UserBusinessService resultData =
                  UserBusinessService.fromJSON(response.data);
              setState(() {
                userBusinessService = resultData;
                _nameController.text = userBusinessService!.name;
                _descriptionController.text = userBusinessService!.description;

              });
            } else {
              Fluttertoast.showToast(
                  msg: '그룹 정보를 받아오는 도중 오류가 발생했습니다.\n오류코드: 463');
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

    ImageProvider serviceImage;

    if (userBusinessService != null && userBusinessService!.has_image != null) {
      serviceImage = CachedNetworkImageProvider(
        Utils.getImageFilePath(userBusinessService!.has_image!),
      );
    } else {
      serviceImage = AssetImage('assets/images/no-image.png');
    }

    final bottomTextStyle = TextStyle(
      color: Color(0xFF232323),
      fontSize: 14.0,
      //fontWeight: FontWeight.w600
    );

    return DefaultNextLayout(
        titleName: userBusinessServiceId != null ? '서비스 수정' : '서비스 등록',
        isProcessable: true,
        bottomBar: true,
        isCancel: false,
        prevOnPressed: () {},
        nextOnPressed: () {
          userBusinessServiceId != null ? _modify() : _submit();
        },
        nextTitle: userBusinessServiceId != null ? '수정하기' : '등록하기',
        prevTitle: '',
        child: SingleChildScrollView(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Column(
              children: [
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
                                            .pickImage(
                                                source: ImageSource.camera)
                                            .then((xfile) {
                                          if (xfile != null) {
                                            setState(() {
                                              _pickedImage = File(xfile.path);
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
                                            .pickImage(
                                                source: ImageSource.gallery)
                                            .then((xfile) {
                                          if (xfile != null) {
                                            setState(() {
                                              _pickedImage = File(xfile.path);
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
                      ? ( userBusinessService != null && userBusinessService!.has_image != null) ?
                        Container(
                          width: double.infinity,
                          height: 240.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: serviceImage, fit: BoxFit.cover)
                          ),
                        )
                      : Container(
                          width: double.infinity,
                          height: 240.0,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.camera_alt,
                                color: Color(0xFFD9D9D9),
                                size: 60.0,
                              ),
                              Text(
                                '이미지 등록 해주세요',
                                style: TextStyle(color: Color(0xFFA2A2A2)),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          width: double.infinity,
                          height: 240.0,
                          child:
                          Image.file(
                            _pickedImage!,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        '서비스명',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13.0,
                        ),
                      ),
                    ),
                    TextFormField(
                        controller: _nameController,
                        decoration: SettingStyle.INPUT_STYLE.copyWith(
                          hintText: '서비스명을 입력해주세요.',
                        )
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        '서비스 설명',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13.0,
                        ),
                      ),
                    ),
                    TextFormField(
                        controller: _descriptionController,
                        maxLines: 4,
                        decoration: SettingStyle.INPUT_STYLE.copyWith(
                          hintText: '서비스 설명을 입력해주세요.',
                        )
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  _submit() async {
    CustomDialog.showProgressDialog(context);

    storeUserBusinessService({
      'user_business_id': userBusinessId,
      'name': _nameController.text,
      'description': _descriptionController.text,
    }, _pickedImage).then((response) async {
      CustomDialog.dismissProgressDialog();

      if (response.status == 'success') {
        _showCompleteDialog(context);
      } else {
        CustomDialog.showServerValidatorErrorMsg(response);
      }
    });
  }

  _modify() async {
    CustomDialog.showProgressDialog(context);

    updateUserBusinessService(userBusinessServiceId!, {
      'name': _nameController.text,
      'description': _descriptionController.text,
    }, _pickedImage).then((response) async {
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
          messageTitle: '서비스 저장 완료',
          messageText: '서비스 저장이 완료 되었습니다.',
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
