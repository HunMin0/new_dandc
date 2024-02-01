import 'dart:io';

import 'package:Deal_Connect/components/alert/show_complete_dialog.dart';
import 'package:Deal_Connect/components/custom/join_text_form_field.dart';
import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/components/layout/default_next_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GroupBoardCreate extends StatefulWidget {
  const GroupBoardCreate({super.key});

  @override
  State<GroupBoardCreate> createState() => _GroupBoardCreateState();
}

class _GroupBoardCreateState extends State<GroupBoardCreate> {
  File? _pickedImage;
  TextEditingController _controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final bottomTextStyle = TextStyle(
      color: Color(0xFF232323),
      fontSize: 14.0,
      //fontWeight: FontWeight.w600
    );


    return DefaultNextLayout(
        nextTitle: '게시글 등록',
        prevTitle: '',
        titleName: '서초구 고기집 사장모임',
        isCancel: false,
        isProcessable: true,
        bottomBar: true,
        nextOnPressed: (){ _showCompleteDialog(context); },
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
                                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                                        child: Text('카메라로 촬영', style: bottomTextStyle,),
                                      ),
                                      onTap: (){
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
            
                                    Divider(height: 1.0, color: Color(0xFFdddddd),),
            
                                    GestureDetector(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                                        child: Text('앨범에서 가져오기', style: bottomTextStyle,),
                                      ),
                                      onTap: (){
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
                  },
                  child: _pickedImage == null
                      ? Container(
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
                  label: '제목',
                  hintText: '제목을 입력해주세요.',
                  onChanged: (String value) {
                  }
                ),
                SizedBox(height: 10,),
                JoinTextFormField(
                    label: '내용',
                    hintText: '내용을 입력해주세요.',
                    maxLines: 8,
                    maxLength: null,
                    onChanged: (String value) {
                    }
                ),
              ],
            ),
          ),
        )
    );
  }


  void _showCompleteDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ShowCompleteDialog(
          messageTitle: '등록완료',
          messageText: '등록이 완료되었습니다.',
          buttonText: '확인',
          onConfirmed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
