import 'package:flutter/material.dart';

class ExpendedElevatedButton extends StatelessWidget {
  String btnName;
  Color? backgroundColor;
  Color? textColor;
  VoidCallback onPressed;

  ExpendedElevatedButton({
    required this.btnName,
    required this.onPressed,
    this.backgroundColor = const Color(0xFFF5F6FA),
    this.textColor = Colors.black,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          backgroundColor: backgroundColor,
          foregroundColor: backgroundColor,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        child: Text(
          btnName,
          style: TextStyle(
              color: textColor, fontSize: 14.0, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
