import 'dart:convert';
import 'dart:io';

import 'package:Deal_Connect/components/const/setting_colors.dart';
import 'package:Deal_Connect/components/custom/join_text_form_field.dart';
import 'package:Deal_Connect/components/layout/default_next_layout.dart';
import 'package:Deal_Connect/model/search_address_result.dart';
import 'package:Deal_Connect/pages/profile/company_create/company_create_step_two.dart';
import 'package:flutter/material.dart';

class CompanyCreateStepOne extends StatefulWidget {
  const CompanyCreateStepOne({super.key});

  @override
  State<CompanyCreateStepOne> createState() => _CompanyCreateStepOneState();
}

class _CompanyCreateStepOneState extends State<CompanyCreateStepOne> {
  int userBusinessCategoryId = 0;
  File? imageFile;

  String name = '';
  String phone = '';
  String zipcode = '';
  double? latitude;
  double? longitude;
  String address1 = '';
  String address2 = '';

  bool isProcessable = false;
  bool isPhoneFilled = false;
  bool isCompanyNameFilled = false;
  bool isAddressFilled = true;
  bool isDetailedAddressFilled = false;

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
          });
        }
      }
    });
  }

  void _showPopup(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('주소검색'),
            content: Text('주소모달 내용'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('확인'),
              ),
            ],
          );
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
                'name': name,
                'phone': phone,
                'address1': address1,
                'address2': address2,
              });
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isCompanyNameFilled
                    ? (isAddressFilled
                        ? (isDetailedAddressFilled
                            ? '다음을 눌러 업체등록을 완성해주세요'
                            : '상세주소를 입력 해주세요')
                        : '주소를 입력 해주세요')
                    : '업체명을 입력 해주세요',
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Column(
                children: [
                  JoinTextFormField(
                    label: '업체명',
                    hintText: '업체명을 입력해주세요',
                    onChanged: (String value) {
                      setState(() {
                        name = value;
                        isCompanyNameFilled = value.isNotEmpty;
                        isProcessable = isCompanyNameFilled &&
                            isAddressFilled &&
                            isDetailedAddressFilled;
                      });
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  _buildAddressSearchBtn(context),
                  SizedBox(
                    height: 10.0,
                  ),
                  JoinTextFormField(
                    label: '연락처',
                    hintText: '연락처를 입력해주세요',
                    onChanged: (String value) {
                      setState(() {
                        phone = value;
                        isPhoneFilled = value.isNotEmpty;
                        isProcessable = isCompanyNameFilled &&
                            isAddressFilled &&
                            isPhoneFilled &&
                            isDetailedAddressFilled;
                      });
                    },
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
                        address1 ?? '여기를 눌러 주소 검색',
                        style: TextStyle(color: BODY_TEXT_COLOR),
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
        JoinTextFormField(
          label: '상세주소',
          hintText: '상세주소를 입력 해주세요',
          onChanged: (String value) {
            setState(() {
              address2 = value;
              isDetailedAddressFilled = value.isNotEmpty;
              isProcessable = isCompanyNameFilled &&
                  isAddressFilled &&
                  isDetailedAddressFilled;
            });
          },
        ),
      ],
    );
  }
  void _searchEvent() {
    Navigator.pushNamed(context, '/address/search').then((value) {
      if (value != null) {
        String valueStr = value as String;
        var jsonBody = json.decode(valueStr);
        SearchAddressResult searchAddressResult = SearchAddressResult.fromJSON(jsonBody);
        setState(() {
          address1 = searchAddressResult.addr;
          zipcode = searchAddressResult.zonecode;

          // latitude = double.parse(searchAddressResult.lat);
          // longitude = double.parse(searchAddressResult.lon);
        });
      }
    });
  }

}
