import 'dart:convert';
import 'dart:io';

import 'package:Deal_Connect/api/group.dart';
import 'package:Deal_Connect/components/alert/show_complete_dialog.dart';
import 'package:Deal_Connect/components/const/setting_colors.dart';
import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/components/layout/default_next_layout.dart';
import 'package:Deal_Connect/components/loading.dart';
import 'package:Deal_Connect/model/group.dart';
import 'package:Deal_Connect/utils/custom_dialog.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class GroupRegisterIndex extends StatefulWidget {
  const GroupRegisterIndex({super.key});

  @override
  State<GroupRegisterIndex> createState() => _GroupRegisterIndexState();
}

class _GroupRegisterIndexState extends State<GroupRegisterIndex> {
  File? _pickedImage;
  late final List<String> keywords = [];
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Group? groupData;
  int? groupId;
  String? groupName;
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
            groupName = args['groupName'];
          });
        }

        if (groupId != null) {
          await getGroup(groupId!).then((response) {
            if (response.status == 'success') {
              Group resultData = Group.fromJSON(response.data);
              setState(() {
                groupData = resultData;
                _nameController.text = groupData!.name;
                if (groupData!.description != null) {
                  _descriptionController.text = groupData!.description ?? '';
                }
                if (groupData!.has_keywords != null) {
                  if (groupData!.has_keywords != null) {
                    for (var keywordItem in groupData!.has_keywords!) {
                      keywords.add(keywordItem.keyword);
                    }
                  }
                }
              });
            } else {
              Fluttertoast.showToast(
                  msg: '그룹 정보를 받아오는 도중 오류가 발생했습니다.\n오류코드: 463');
            }
          });
        }

      }
    });

    setState(() {
      _isLoading = false;
    });
  }

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
  Widget build(BuildContext context) {

    ImageProvider groupImage;

    if (groupData != null && groupData!.has_group_image != null) {
      groupImage = CachedNetworkImageProvider(
        Utils.getImageFilePath(groupData!.has_group_image!),
      );
    } else {
      groupImage = const AssetImage('assets/images/no-image.png');
    }

    final baseBorder = const OutlineInputBorder(
      borderSide: BorderSide(
        color: INPUT_BORDER_COLOR,
        width: 1.0,
      ),
    );

    final bottomTextStyle = const TextStyle(
      color: Color(0xFF232323),
      fontSize: 14.0,
      //fontWeight: FontWeight.w600
    );

    if (_isLoading) {
      // 로딩 중 인디케이터 표시
      return const Loading();
    }

    return DefaultNextLayout(
        nextTitle: '저장하기',
        prevTitle: '취소',
        titleName: '그룹정보',
        isCancel: false,
        isProcessable: true,
        bottomBar: true,
        prevOnPressed: () {},
        nextOnPressed: () {
          groupId != null ? _modify() : _submit();
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
                                        const Divider(
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
                          ? (groupData != null &&
                                groupData!.has_group_image != null)
                              ? Container(
                                  width: double.infinity,
                                  height: 240.0,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: groupImage,
                                          fit: BoxFit.cover)),
                                )
                              : Container(
                                  width: double.infinity,
                                  height: 180.0,
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
                                        style:
                                            TextStyle(color: Color(0xFFA2A2A2)),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            '그룹 이름',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 13.0,
                            ),
                          ),
                        ),
                        TextFormField(
                            controller: _nameController,
                            decoration: SettingStyle.INPUT_STYLE.copyWith(
                              hintText: '그룹 이름을 입력해주세요.',
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            '그룹 간단 소개',
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
                              hintText: '그룹 간단 소개 내용을 입력해주세요.',
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
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
                            border: baseBorder,
                            enabledBorder: baseBorder,
                            focusedBorder: baseBorder.copyWith(
                              borderSide: baseBorder.borderSide.copyWith(
                                color: PRIMARY_COLOR,
                              ),
                            ),
                            contentPadding: const EdgeInsets.all(12.0),
                            labelText: '키워드 추가',
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: _addKeyword,
                            ),
                          ),
                          onSubmitted: (value) => _addKeyword(),
                        ),
                        const SizedBox(height: 10),
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
      'name': _nameController.text,
      'description': _descriptionController.text,
      'keywords': jsonEncode(keywords),
    }, _pickedImage)
        .then((response) async {
      CustomDialog.dismissProgressDialog();

      if (response.status == 'success') {
        Group resultData = Group.fromJSON(response.data);
        setState(() {
          groupData = resultData;
        });
        _showCompleteDialog(context);
      } else {
        CustomDialog.showServerValidatorErrorMsg(response);
      }
    });
  }

  _modify() async {
    CustomDialog.showProgressDialog(context);

    updateGroup(groupId!, {
      'name': _nameController.text,
      'description': _descriptionController.text,
      'keywords': jsonEncode(keywords),
    }, _pickedImage)
        .then((response) async {
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
          messageTitle: '그룹 저장 완료',
          messageText: '저장이 완료되었습니다.',
          buttonText: '확인',
          onConfirmed: () {
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.popAndPushNamed(context, '/group/info',
                arguments: {'groupId': groupData!.id});
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
