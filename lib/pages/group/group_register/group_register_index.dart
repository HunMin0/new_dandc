import 'dart:convert';
import 'dart:io';

import 'package:Deal_Connect/api/group.dart';
import 'package:Deal_Connect/components/alert/show_complete_dialog.dart';
import 'package:Deal_Connect/components/const/setting_colors.dart';
import 'package:Deal_Connect/components/custom/common_text_form_filed.dart';
import 'package:Deal_Connect/components/custom/join_text_form_field.dart';
import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/components/layout/default_next_layout.dart';
import 'package:Deal_Connect/model/group.dart';
import 'package:Deal_Connect/utils/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

class GroupRegisterIndex extends StatefulWidget {
  const GroupRegisterIndex({super.key});

  @override
  State<GroupRegisterIndex> createState() => _GroupRegisterIndexState();
}

class _GroupRegisterIndexState extends State<GroupRegisterIndex> {
  String name = '';
  String description = '';
  File? _pickedImage;
  final List<String> keywords = [];
  final TextEditingController _controller = TextEditingController();

  void _addKeyword() {
    final text = _controller.text;
    if (text.isNotEmpty && keywords.length < 10) {
      setState(() {
        keywords.add(text);
        _controller.clear();
      });
    }
  }

  void _removeKeyword(String keyword) {
    setState(() {
      keywords.remove(keyword);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: INPUT_BORDER_COLOR,
        width: 1.0,
      ),
    );

    final bottomTextStyle = TextStyle(
      color: Color(0xFF232323),
      fontSize: 14.0,
      //fontWeight: FontWeight.w600
    );

    return DefaultNextLayout(
        nextTitle: '저장하기',
        prevTitle: '취소',
        titleName: '그룹 만들기',
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
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
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
                                                  _pickedImage =
                                                      File(xfile.path);
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
                                                  _pickedImage =
                                                      File(xfile.path);
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
                          ? Container(
                              width: double.infinity,
                              height: 180.0,
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
                                    '이미지 등록 해주세요',
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
                    JoinTextFormField(
                        label: '그룹 이름',
                        hintText: '그룹 이름을 입력해주세요.',
                        onChanged: (String value) {
                          setState(() {
                            name = value;
                          });
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    JoinTextFormField(
                        label: '그룹 간단 소개',
                        hintText: '그룹 간단 소개 내용을 입력해주세요.',
                        maxLines: 4,
                        maxLength: null,
                        onChanged: (String value) {
                          description = value;
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            '검색 키워드',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 13.0,
                            ),
                          ),
                        ),
                        TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            fillColor: INPUT_BG_COLOR,
                            filled: true,
                            // fillColor에 배경색이 있을 경우 색상반영, false 미적용
                            // 기본보더
                            border: baseBorder,
                            // 선택되지 않은상태에서 활성화 되어있는 필드
                            enabledBorder: baseBorder,
                            // 포커스보더
                            focusedBorder: baseBorder.copyWith(
                              borderSide: baseBorder.borderSide.copyWith(
                                color: PRIMARY_COLOR,
                              ),
                            ),
                            contentPadding: EdgeInsets.all(12.0),
                            // 필드 패딩
                            labelText: '키워드 추가',
                            suffixIcon: IconButton(
                              icon: Icon(Icons.add),
                              onPressed: _addKeyword,
                            ),
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
            )));
  }

  _submit() async {
    CustomDialog.showProgressDialog(context);

    storeGroup({
      'name': name,
      'description': description,
      'keywords': jsonEncode(keywords),
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
          messageTitle: '그룹 등록 완료',
          messageText: '등록이 완료되었습니다.',
          buttonText: '확인',
          onConfirmed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/group', (route) => false);
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
