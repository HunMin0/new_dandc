import 'dart:convert';
import 'dart:io';

import 'package:Deal_Connect/api/auth.dart';
import 'package:Deal_Connect/components/alert/show_complete_dialog.dart';
import 'package:Deal_Connect/components/const/setting_colors.dart';
import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/components/custom/join_text_form_field.dart';
import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/components/layout/default_next_layout.dart';
import 'package:Deal_Connect/model/user.dart';
import 'package:Deal_Connect/utils/custom_dialog.dart';
import 'package:Deal_Connect/utils/shared_pref_utils.dart';
import 'package:Deal_Connect/components/const/setting_colors.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEditIndex extends StatefulWidget {
  const ProfileEditIndex({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileEditIndex> createState() => _ProfileEditIndexState();
}

class _ProfileEditIndexState extends State<ProfileEditIndex> {
  User? myPageData;
  File? _pickedImage;
  String name = '';
  String phone = '';
  String email = '';
  List<String> keywords = [];
  final TextEditingController _keywordTextController = TextEditingController();
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _phoneTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();

  bool isProcessable = false;

  @override
  void initState() {
    super.initState();
    _initUserMyData();
  }

  void _initUserMyData() {
    getMyUser().then((response) {
      if (response.status == 'success') {
        User user = User.fromJSON(response.data);
        setState(() {
          myPageData = user;
          _nameTextController.text = myPageData!.name;
          _phoneTextController.text = myPageData!.phone!;
          _emailTextController.text = myPageData!.email!;
          keywords = keywords = myPageData!.has_keywords!
              .map((userKeyword) => userKeyword.keyword)
              .toList();
        });
      }
    });
  }


  void _addKeyword() {
    final text = _keywordTextController.text;
    if (text.isNotEmpty && keywords.length < 10) {
      setState(() {
        keywords.add(text);
        _keywordTextController.clear();
      });
    }
  }

  void _removeKeyword(String keyword) {
    setState(() {
      keywords.remove(keyword);
    });
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider? backgroundImage;

    if (myPageData != null &&
        myPageData!.profile != null &&
        myPageData!.profile!.has_profile_image != null) {
      backgroundImage = CachedNetworkImageProvider(
        Utils.getImageFilePath(
            myPageData!.profile!.has_profile_image!),
      );
    } else {
      backgroundImage = AssetImage('assets/images/no-image.png');
    }

    final bottomTextStyle = TextStyle(
      color: Color(0xFF232323),
      fontSize: 14.0,
      //fontWeight: FontWeight.w600
    );



    return DefaultNextLayout(
      titleName: '프로필 수정',
      nextTitle: '저장하기',
      prevTitle: '취소',
      isCancel: false,
      isProcessable: true,
      bottomBar: true,
      prevOnPressed: () {},
      nextOnPressed: () {
        _submit();
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  buildShowModalBottomSheet(context, bottomTextStyle);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 150,
                          height: 150.0,
                          decoration: BoxDecoration(
                            color: Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.all(
                              Radius.circular(75.0),
                            ),
                          ),
                          child: Stack(
                            fit: StackFit.expand,
                            // Stack 내의 children을 컨테이너 크기에 맞춥니다.
                            clipBehavior: Clip.none,
                            // 자식이 Stack 범위 밖으로 나가도록 허용
                            children: [
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(75.0)),
                                child: _pickedImage == null
                                    ? Image(
                                        image: backgroundImage,
                                        fit: BoxFit
                                            .cover, // 이미지가 컨테이너를 꽉 채우도록 조정
                                      )
                                    : Image.file(
                                        _pickedImage!,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.settings,
                                    color: Colors.grey,
                                    size: 40,
                                  ),
                                  onPressed: () {
                                    buildShowModalBottomSheet(
                                        context, bottomTextStyle);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      '이름',
                      style: SettingStyle.NORMAL_TEXT_STYLE,
                    ),
                  ),
                  TextFormField(
                    controller: _nameTextController,
                    decoration: SettingStyle.INPUT_STYLE
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      '전화번호',
                      style: SettingStyle.NORMAL_TEXT_STYLE,
                    ),
                  ),
                  TextFormField(
                      controller: _phoneTextController,
                      decoration: SettingStyle.INPUT_STYLE
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      '이메일',
                      style: SettingStyle.NORMAL_TEXT_STYLE,
                    ),
                  ),
                  TextFormField(
                      controller: _emailTextController,
                      decoration: SettingStyle.INPUT_STYLE
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      '검색 키워드',
                      style: SettingStyle.NORMAL_TEXT_STYLE,
                    ),
                  ),
                  TextField(
                    controller: _keywordTextController,
                    decoration: SettingStyle.INPUT_STYLE.copyWith(
                      labelText: '키워드 추가',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.add),
                        onPressed: _addKeyword,
                      )
                    ),
                    onSubmitted: (value) => _addKeyword(),
                  ),
                  SizedBox(height: 10),
                  Wrap(
                    spacing: 8.0, // 각 Chip의 간격
                    children: keywords
                        .map((keyword) => Chip(
                      label: Text(keyword),
                      onDeleted: () => _removeKeyword(keyword),
                    ))
                        .toList(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> buildShowModalBottomSheet(
      BuildContext context, TextStyle bottomTextStyle) {
    return showModalBottomSheet(
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
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
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
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
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
  }

  _submit() async {
    CustomDialog.showProgressDialog(context);

    updateProfile({
      'name': _nameTextController.text,
      'phone': _phoneTextController.text,
      'email': _emailTextController.text,
      'keywords': jsonEncode(keywords),
    }, _pickedImage).then((response) async {
      CustomDialog.dismissProgressDialog();

      if (response.status == 'success') {

        User user = User.fromJSON(response.data);
        SharedPrefUtils.setUser(user).then((value) {
          print(value);
          _showCompleteDialog(context);
        });

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
          messageTitle: '프로필 수정 완료',
          messageText: '프로필 수정이 완료 되었습니다.',
          buttonText: '확인',
          onConfirmed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
