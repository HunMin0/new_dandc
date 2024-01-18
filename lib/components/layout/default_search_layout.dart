import 'package:Deal_Connect/components/const/setting_colors.dart';
import 'package:Deal_Connect/pages/search/search_partner_list.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class DefaultSearchLayout extends StatelessWidget {
  final Function(String) onSubmit;
  final Widget child;
  final Color? backgroundColor;
  final String? isNotInnerPadding;

  const DefaultSearchLayout(
      {required this.child,
      required this.onSubmit,
      this.backgroundColor,
      this.isNotInnerPadding,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? SettingColors.primaryMeterialColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                onSubmitted: (value) {
                  // 여기에 키패드 서브밋이 발생했을 때 수행할 작업을 추가합니다.
                  onSubmit(value);
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: HexColor("#F5F6FA"),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100.0), // 테두리를 둥글게 설정
                    borderSide: BorderSide.none, // 바텀 border 없애기
                  ),
                  hintText: '검색 키워드를 입력해주세요',
                ),
              ),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  '취소',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: HexColor("#666666")),
                ))
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: isNotInnerPadding == 'true'
              ? const EdgeInsets.all(0.0)
              : const EdgeInsets.all(20.0),
          child: child,
        ),
      ),
    );
  }

  Test() {
    return 'test';
  }
}
