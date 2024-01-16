import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:Deal_Connect/components/const/setting_colors.dart';

class DefaultLogoLayout extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final String? titleName;
  final String? isNotInnerPadding;

  const DefaultLogoLayout({
    this.titleName,
    required this.child,
    this.backgroundColor,
    this.isNotInnerPadding,

    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? SettingColors.primaryMeterialColor,
      appBar: AppBar(
        title: titleName != null
            ? Text(titleName!, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),)
            : Image.asset(
          'assets/images/logo.png',
          width: 180.0, //MediaQuery.of(context).size.width / 2,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: isNotInnerPadding == 'true' ? const EdgeInsets.all(0.0) : const EdgeInsets.all(20.0),
          child: child,
        ),
      ),
    );
  }
}
