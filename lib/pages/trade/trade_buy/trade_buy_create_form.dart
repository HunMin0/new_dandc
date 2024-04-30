import 'dart:io';
import 'dart:ui';

import 'package:Deal_Connect/components/const/setting_colors.dart';
import 'package:Deal_Connect/components/custom/join_text_form_field.dart';
import 'package:Deal_Connect/form_data/trade_form_data.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class TradeBuyCreateForm extends StatefulWidget {
  final TradeFormData formData;
  final Function(bool) onProcessableChanged;


  TradeBuyCreateForm({required this.formData, required this.onProcessableChanged});

  @override
  State<TradeBuyCreateForm> createState() => _TradeBuyCreateFormState();
}

class _TradeBuyCreateFormState extends State<TradeBuyCreateForm> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    final bottomTextStyle = TextStyle(
      color: Color(0xFF232323),
      fontSize: 14.0,
      //fontWeight: FontWeight.w600
    );

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SingleChildScrollView(
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
              GestureDetector(
                onTap: () {
                  _selectDate(context);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text("거래일자",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 13.0)),
                    ),
                    Container(
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                          color: INPUT_BG_COLOR,
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          border: Border.all(color: INPUT_BORDER_COLOR)),
                      child: Row(
                        children: [
                          Text(
                            selectedDate != null
                                ? selectedDate.toString().split(" ")[0]
                                : "날짜를 선택하세요.",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: BODY_TEXT_COLOR),
                          ),
                          Spacer(),
                          Icon(Icons.date_range),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              JoinTextFormField(
                  label: "거래항목",
                  hintText: '거래항목을 입력해주세요.',
                  onChanged: (String value) {
                    widget.formData.tradeServices = value;
                    _checkProcessable();
                  }),
              SizedBox(
                height: 10,
              ),
              JoinTextFormField(
                  label: "거래금액",
                  isNumber: true,
                  hintText: '거래금액을 숫자만 입력해주세요',
                  onChanged: (String value) {
                    widget.formData.price = value;
                    _checkProcessable();
                  }),
              SizedBox(
                height: 10,
              ),
              JoinTextFormField(
                  label: '파트너님께 한마디',
                  hintText: '거래내역 승인요청과 함께, 파트너님께 전할 말씀을 입력해주세요.',
                  maxLines: 5,
                  maxLength: null,
                  onChanged: (String value) {
                    widget.formData.userDescription = value;
                    _checkProcessable();
                  }),
              SizedBox(
                height: 20,
              ),
              Text(
                "영수증 첨부",
                style: TextStyle(fontSize: 13),
              ),
              SizedBox(
                height: 10,
              ),
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
                                          .pickImage(source: ImageSource.camera)
                                          .then((xfile) {
                                        if (xfile != null) {
                                          setState(() {
                                            widget.formData.receiptFile =
                                                File(xfile.path);
                                            _checkProcessable();
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
                                          .pickImage(source: ImageSource.gallery)
                                          .then((xfile) {
                                        if (xfile != null) {
                                          setState(() {
                                            widget.formData.receiptFile =
                                                File(xfile.path);
                                            _checkProcessable();
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
                child: widget.formData.receiptFile == null
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
                              style: TextStyle(
                                  color: Color(0xFFA2A2A2), fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : Container(
                        width: double.infinity,
                        height: 240.0,
                        child: Image.file(
                          widget.formData.receiptFile!,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            datePickerTheme: DatePickerThemeData(
              surfaceTintColor: Colors.white
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      setState(() {
        selectedDate = picked;
        widget.formData.tradedAt = formattedDate;
      });
      _checkProcessable();
    }
  }

  void _checkProcessable() {
    bool isProcessable = widget.formData.tradedAt != null &&
        widget.formData.tradeServices != null &&
        widget.formData.price != null;

    widget.onProcessableChanged(isProcessable);
  }
}
