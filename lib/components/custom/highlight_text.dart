import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class HighlightText extends StatelessWidget {
  String content;
  double fontSize;
  double borderRadius;
  double topMargin;
  double leftMargin;
  double paddingVertical;
  double paddingHorizontal;
  String bgHexColor;
  String textHexColor;

  HighlightText({
    this.content = 'HIT',
    this.fontSize = 10,
    this.borderRadius = 10,
    this.topMargin = 3,
    this.leftMargin = 4,
    this.paddingVertical = 2,
    this.paddingHorizontal = 7,
    this.bgHexColor = '293bf0',
    this.textHexColor = 'ffffff',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: topMargin, left: leftMargin),
      decoration: BoxDecoration(
        color: HexColor('#' + bgHexColor),
        // borderRadius: BorderRadius.circular(borderRadius),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      padding: EdgeInsets.symmetric(vertical: paddingVertical, horizontal: paddingHorizontal),
      child: Text(
        content,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
          color: HexColor('#' + textHexColor),
        ),
      ),
    );
  }
}