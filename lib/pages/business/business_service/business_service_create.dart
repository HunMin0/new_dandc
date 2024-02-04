import 'dart:io';

import 'package:Deal_Connect/components/custom/join_text_form_field.dart';
import 'package:Deal_Connect/components/layout/default_next_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BusinessServiceCreate extends StatefulWidget {
  const BusinessServiceCreate({super.key});

  @override
  State<BusinessServiceCreate> createState() => _BusinessServiceCreateState();
}

class _BusinessServiceCreateState extends State<BusinessServiceCreate> {
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
      titleName: '서비스 등록',
      isProcessable: true,
      bottomBar: true,
      isCancel: false,
      prevOnPressed: () {},
      nextOnPressed: (){Navigator.pop(context);},
      nextTitle: '등록하기',
      prevTitle: '',
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
                    label: '서비스명',
                    hintText: '서비스명을 입력해주세요.',
                    onChanged: (String value) {
                    }
                ),
                SizedBox(height: 10,),
                JoinTextFormField(
                    label: '제품 설명',
                    hintText: '제품 설명을 입력해주세요.',
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
}
