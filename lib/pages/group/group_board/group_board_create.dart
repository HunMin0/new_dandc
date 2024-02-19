import 'dart:convert';
import 'dart:io';

import 'package:Deal_Connect/api/board.dart';
import 'package:Deal_Connect/components/alert/show_complete_dialog.dart';
import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/components/custom/input_file_grid.dart';
import 'package:Deal_Connect/components/custom/join_text_form_field.dart';
import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/components/layout/default_next_layout.dart';
import 'package:Deal_Connect/components/loading.dart';
import 'package:Deal_Connect/items/image_picker_item.dart';
import 'package:Deal_Connect/model/board_write.dart';
import 'package:Deal_Connect/utils/custom_dialog.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class GroupBoardCreate extends StatefulWidget {
  const GroupBoardCreate({super.key});

  @override
  State<GroupBoardCreate> createState() => _GroupBoardCreateState();
}

class _GroupBoardCreateState extends State<GroupBoardCreate> {
  File? _pickedImage;
  List <ImagePickerItem> boardImageList = [];

  TextEditingController _controller = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  int? groupId;
  int? boardWriteId;
  String? groupName;
  String title = '';
  String content = '';
  bool _isLoading = true;
  BoardWrite? boardWriteData;


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
            boardWriteId = args['boardWriteId'];
            groupId = args['groupId'];
            groupName = args['groupName'];
          });
        }

        if (boardWriteId != null) {
          await getBoardWrite(boardWriteId!).then((response) {
            if (response.status == 'success') {
              BoardWrite resultData = BoardWrite.fromJSON(response.data);
              setState(() {
                boardWriteData = resultData;
                _titleController.text = boardWriteData!.title;
                _contentController.text = boardWriteData!.content;
              });
            } else {
              Fluttertoast.showToast(
                  msg: '게시물 정보를 받아오는 도중 오류가 발생했습니다.\n오류코드: 462');
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


    List<String> imgUrls = [];
    if (boardWriteData != null) {
      if (boardWriteData!.has_files != null && boardWriteData!.has_files!.isNotEmpty) {
        imgUrls.addAll(boardWriteData!.has_files!.map((e) => Utils.getImageFilePath(e.has_file!)));
      }
    }


    if (_isLoading) {
      // 로딩 중 인디케이터 표시
      return Loading();
    }

    return DefaultNextLayout(
        nextTitle: boardWriteId != null ? '게시글 수정' : '게시글 등록',
        prevTitle: '',
        titleName: groupName,
        isCancel: false,
        isProcessable: true,
        bottomBar: true,
        nextOnPressed: (){ boardWriteId != null ? _modify() : _submit(); },
        prevOnPressed: (){},
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
                    decoration: boardWriteId != null ? BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(imgUrls[0])
                      ),
                    )
                        : const BoxDecoration(
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
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        '제목',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13.0,
                        ),
                      ),
                    ),
                    TextField(
                      controller: _titleController,
                      decoration: SettingStyle.INPUT_STYLE.copyWith(
                        hintText: '제목을 입력해주세요.',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        '제목',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13.0,
                        ),
                      ),
                    ),
                    TextField(
                      controller: _contentController,
                      maxLines: 8,
                      decoration: SettingStyle.INPUT_STYLE.copyWith(
                        hintText: '내용을 입력해주세요.',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                // InputFileGrid(imageList: boardImageList, isAddable: false,),
              ],
            ),
          ),
        )
    );


  }

  _submit() async {
    CustomDialog.showProgressDialog(context);

    storeGroupBoardWrite({
      'group_id': groupId,
      'board_title': _titleController.text,
      'board_content': _contentController.text,
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

    updateGroupBoardWrite(boardWriteId!, {
      'group_id': groupId,
      'board_title': _titleController.text,
      'board_content': _contentController.text,
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
          messageTitle: '게시글 저장 완료',
          messageText: '게시글 저장이 완료 되었습니다.',
          buttonText: '확인',
          onConfirmed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        );
      },
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


  @override
  void dispose() {
    super.dispose();
  }
}
