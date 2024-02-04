import 'dart:io';
import 'dart:ui';

import 'package:Deal_Connect/components/custom/date_picker_text_field.dart';
import 'package:Deal_Connect/components/custom/join_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TradeBuyCreateForm extends StatefulWidget {
  const TradeBuyCreateForm({super.key});

  @override
  State<TradeBuyCreateForm> createState() => _TradeBuyCreateFormState();
}

class _TradeBuyCreateFormState extends State<TradeBuyCreateForm> {
  File? _pickedImage;

  @override
  Widget build(BuildContext context) {
    final bottomTextStyle = TextStyle(
      color: Color(0xFF232323),
      fontSize: 14.0,
      //fontWeight: FontWeight.w600
    );
    
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "상세정보를 입력해주세요.",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
            JoinTextFormField(
              label: "거래일자",
              hintText: '거래일자를 입력해주세요.',
              onChanged: (String value) {
              }
            ),
            // DatePickerTextField(),
            SizedBox(height: 10,),
            JoinTextFormField(
                label: "거래항목",
                hintText: '거래항목을 입력해주세요.',
                onChanged: (String value) {
                }
            ),
            SizedBox(height: 10,),
            JoinTextFormField(
                label: "거래금액",
                hintText: '거래금액을 숫자만 입력해주세요',
                onChanged: (String value) {
                }
            ),
            SizedBox(height: 10,),
            JoinTextFormField(
                label: '파트너님께 한마디',
                hintText: '거래내역 승인요청과 함께, 파트너님께 전할 말씀을 입력해주세요.',
                maxLines: 5,
                maxLength: null,
                onChanged: (String value) {
                }
            ),
            SizedBox(height: 20,),
            Text("영수증 첨부", style: TextStyle(fontSize: 13),),
            SizedBox(height: 10,),
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
                height: 150.0,
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
                      Icons.receipt_long_outlined,
                      color: Color(0xFFD9D9D9),
                      size: 50.0,
                    ),
                    Text(
                      '영수증을 첨부하시면\n일반적으로 더 빨리 승인이 됩니다.',
                      style: TextStyle(color: Color(0xFFA2A2A2), fontSize: 12),
                      textAlign: TextAlign.center,
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
          ],
        ),
      ),
    );
  }
}
