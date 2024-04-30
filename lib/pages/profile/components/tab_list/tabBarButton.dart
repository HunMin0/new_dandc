import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:flutter/material.dart';

class TabBarButton extends StatelessWidget {
  final String btnTitle;
  final VoidCallback onPressed;

  const TabBarButton({
    required this.btnTitle,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        btnTitle,
        style: SettingStyle.NORMAL_TEXT_STYLE.copyWith(
          color: Colors.white
        )
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 48),
        backgroundColor: Color(0xFF75A8E4),
        foregroundColor: Color(0xFF75A8E4),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    );
  }
}