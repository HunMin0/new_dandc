import 'dart:io';

import 'package:Deal_Connect/api/group.dart';
import 'package:Deal_Connect/components/const/setting_colors.dart';
import 'package:Deal_Connect/components/custom/common_text_form_filed.dart';
import 'package:Deal_Connect/components/custom/custom_text_form_field.dart';
import 'package:Deal_Connect/components/custom/input_file_grid.dart';
import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/items/image_picker_item.dart';
import 'package:Deal_Connect/pages/auth/join/join_index.dart';
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
  final _formKey = GlobalKey<FormState>();
  XFile? _image; //이미지를 담을 변수 선언
  String name = '';
  String description = '';
  List<String> searchKeywords = [];
  String keyword = '';

  final ImagePicker picker = ImagePicker(); //ImagePicker 초기화

  Future getImage(ImageSource imageSource) async {
    //pickedFile에 ImagePicker로 가져온 이미지가 담긴다.
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        _image = XFile(pickedFile.path); //가져온 이미지를 _image에 저장
      });
    }
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final baseStyle = TextButton.styleFrom(
      backgroundColor: PRIMARY_COLOR,
      padding: EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      side: BorderSide(color: PRIMARY_COLOR),
    );


    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
    );

    return DefaultLogoLayout(
      titleName: '그룹 만들기',
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ListView(
          children: [
            Text('그룹 생성을 위해\n아래 정보를 입력해주세요.', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w400),),
            SizedBox(height: 15.0,),
            Form(
              key: _formKey,
              //autovalidateMode: AutovalidateMode.onUserInteraction, // 실시간 유효성 검사 모드 설정
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              getImage(ImageSource.gallery); //getImage 함수를 호출해서 카메라로 찍은 사진 가져오기
                            },
                            child: Text("이미지"),
                          ),
                        ]
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CommonTextFormField(
                          label: '그룹 이름',
                          hintText: '그룹 이름을 입력해주세요.',
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return '그룹 이름을 입력하세요.';
                            }
                            if (value.length < 4) {
                              return '그룹 이름은 2자 이상이어야 합니다.';
                            }
                            return null; // 유효한 경우 null 반환
                          },
                          onChanged: (String value) {
                            setState(() {
                              name = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CommonTextFormField(
                          label: '그룹 간단 소개',
                          hintText: '간단한 사업장 소개를 입력해주세요.',
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return '사업장 소개를 입력하세요.';
                            }
                            return null; // 유효한 경우 null 반환
                          },
                          onChanged: (String value) {
                            setState(() {
                              description = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: CommonTextFormField(
                          label: '키워드',
                          hintText: '키워드 입력 후 추가해주세요.(최대 10개)',
                          onChanged: (String value) {
                            setState(() {
                              keyword = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 8.0),
                      InkWell(
                        onTap: () {
                          if (keyword.isNotEmpty) {
                            setState(() {
                              searchKeywords.add(keyword);
                              keyword = '';
                              FocusScope.of(context).unfocus(); // 키보드 닫기
                            });
                          }
                        },
                        child: Container(
                          width: 48.0,
                          height: 48.0,
                          decoration: BoxDecoration(
                            color: HexColor('F5F6FA'),
                            borderRadius: BorderRadius.circular(10.0), // 여기서 10.0은 원하는 반지름 값입니다.
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/icons/add_icon.png', // 이미지의 경로
                                height: 24.0, // 이미지의 높이
                                width: 24.0, // 이미지의 너비
                              ),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    height: 200,
                    child: Wrap(
                      spacing: 3.0, // Chip 간의 간격 조정
                      runSpacing: 3.0, // Chip이 여러 줄로 나열될 경우 줄 간의 간격 조정
                      children: searchKeywords != null && searchKeywords.isNotEmpty
                          ? searchKeywords.map((keyword) {
                        return Chip(
                          label: Text(
                            keyword,
                            style: TextStyle(fontSize: 12.0), // 폰트 크기 조정
                          ),
                          onDeleted: () {
                            setState(() {
                              searchKeywords.remove(keyword);
                            });
                          },
                        );
                      }).toList()
                          : [
                        Text('키워드를 추가해주세요.')
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Map groupMapData = {
                        'name': name,
                        'description': description,
                        'keywords': searchKeywords,
                      };
                      postRegisterGroup(groupMapData).then((value) {
                        if (value.status == 'success') {
                            Navigator.pushNamed(context, '/login');
                        } else {
                          print(value.message);
                          CustomDialog.showServerValidatorErrorMsg(value);
                        }
                      });

                    },
                    style: TextButton.styleFrom(
                      backgroundColor: PRIMARY_COLOR, // 버튼 상태에 따라 색상 조정
                      padding: EdgeInsets.all(16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      child: const Center(
                        child: Text(
                          '그룹 만들기',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]
        )
      )
    );
  }
}
