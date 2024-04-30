import 'dart:convert';
import 'dart:io';

import 'package:Deal_Connect/components/const/setting_colors.dart';
import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/components/custom/join_text_form_field.dart';
import 'package:Deal_Connect/components/layout/default_next_layout.dart';
import 'package:Deal_Connect/model/search_address_result.dart';
import 'package:Deal_Connect/model/user_business.dart';
import 'package:Deal_Connect/pages/profile/company_create/company_create_step_two.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CompanyCreateStepOne extends StatefulWidget {
  const CompanyCreateStepOne({super.key});

  @override
  State<CompanyCreateStepOne> createState() => _CompanyCreateStepOneState();
}

class _CompanyCreateStepOneState extends State<CompanyCreateStepOne> {
  int userBusinessCategoryId = 0;
  File? imageFile;

  String name = '';
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _address2Controller = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  String phone = '';
  String zipcode = '';
  double? latitude;
  double? longitude;
  String address1 = '';
  String address2 = '';
  String description = '';

  bool isProcessable = false;

  UserBusiness? userBusiness;

  var args;

  @override
  void initState() {
    super.initState();

    final widgetsBinding = WidgetsBinding.instance;
    widgetsBinding?.addPostFrameCallback((callback) {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        args = ModalRoute.of(context)?.settings.arguments;
        if (args != null) {
          setState(() {
            userBusinessCategoryId = args['userBusinessCategoryId'];
            imageFile = args['imageFile'];
            userBusiness = args['userBusiness'];

            if (userBusiness != null) {
              _nameController.text = userBusiness!.name;
              _descriptionController.text = userBusiness!.description ?? '';
              address1 = userBusiness!.address1 ?? '';
              _address2Controller.text = userBusiness!.address2 ?? '';
              _phoneController.text = userBusiness!.phone ?? '';
              isProcessable = true;
            }
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: DefaultNextLayout(
        titleName: '업체등록',
        isProcessable: isProcessable,
        bottomBar: true,
        prevTitle: '취소',
        nextTitle: '다음',
        prevOnPressed: () {
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
        nextOnPressed: () {
          Navigator.pushNamed(context, '/profile/company/create/step2',
              arguments: {
                'userBusinessCategoryId': userBusinessCategoryId,
                'imageFile': imageFile,
                'name': _nameController.text,
                'phone': _phoneController.text,
                'address1': address1,
                'address2': _address2Controller.text,
                'description': _descriptionController.text,
                'userBusiness': userBusiness,
              });
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          '업체명',
                          style: SettingStyle.NORMAL_TEXT_STYLE,
                        ),
                      ),
                      TextField(
                        controller: _nameController,
                        decoration: SettingStyle.INPUT_STYLE.copyWith(
                          hintText: '업체명을 입력해주세요',
                        ),
                        onChanged: (String value) {
                          _checkValidation();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          '한줄소개',
                          style: SettingStyle.NORMAL_TEXT_STYLE,
                        ),
                      ),
                      TextField(
                        controller: _descriptionController,
                        decoration: SettingStyle.INPUT_STYLE.copyWith(
                          hintText: '한 줄 소개를 입력해주세요',
                        ),
                        onChanged: (String value) {
                          _checkValidation();
                        },
                      ),
                    ],
                  ),
                  _buildAddressSearchBtn(context),
                  SizedBox(
                    height: 10.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          '연락처',
                          style: SettingStyle.NORMAL_TEXT_STYLE,
                        ),
                      ),
                      TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.number,
                        decoration: SettingStyle.INPUT_STYLE.copyWith(
                          hintText: '연락처를 입력해주세요',
                        ),
                        onChanged: (String value) {_checkValidation();},
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _buildAddressSearchBtn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            '주소',
            style: SettingStyle.NORMAL_TEXT_STYLE,
          ),
        ),
        GestureDetector(
          onTap: () {
            _searchEvent();
          },
          child: Container(
            width: double.infinity,
            height: 46.0,
            decoration: BoxDecoration(
              color: INPUT_BG_COLOR,
              border: Border.all(
                width: 1.0,
                color: INPUT_BORDER_COLOR,
              ),
            ),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        address1 != '' ? address1 : '주소 검색을 해주세요.',
                        style: SettingStyle.NORMAL_TEXT_STYLE
                            .copyWith(color: HexColor('#666666'), fontSize: 16),
                      ),
                      Icon(
                        Icons.search,
                        color: Color(0xFFABABAB),
                      )
                    ],
                  ),
                )),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                '상세주소',
                style: SettingStyle.NORMAL_TEXT_STYLE,
              ),
            ),
            TextField(
              controller: _address2Controller,
              decoration: SettingStyle.INPUT_STYLE.copyWith(
                hintText: '상세주소를 입력해주세요',
              ),
              onChanged: (String value) {_checkValidation();},
            ),
          ],
        ),
      ],
    );
  }

  void _searchEvent() {
    Navigator.pushNamed(context, '/address/search').then((value) {
      if (value != null) {
        String valueStr = value as String;
        var jsonBody = json.decode(valueStr);
        SearchAddressResult searchAddressResult =
            SearchAddressResult.fromJSON(jsonBody);
        setState(() {
          address1 = searchAddressResult.addr;
          zipcode = searchAddressResult.zonecode;
          _checkValidation();
          // latitude = double.parse(searchAddressResult.lat);
          // longitude = double.parse(searchAddressResult.lon);
        });
      }
    });
  }

  void _checkValidation() {
    if (_nameController.text != '' &&
      _descriptionController.text != '' &&
      address1 != '' &&
      _address2Controller.text != '' &&
      _phoneController.text != ''
    ) {
      setState(() {
        isProcessable = true;
      });
    } else {
      setState(() {
        isProcessable = false;
      });
    }
  }
}
