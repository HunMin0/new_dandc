import 'package:flutter/material.dart';
import 'package:Deal_Connect/components/const/setting_colors.dart';

class DefaultLogoLayout extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final String? titleName;

  const DefaultLogoLayout({
    this.titleName,
    required this.child,
    this.backgroundColor,

    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? SettingColors.primaryMeterialColor,
      appBar: AppBar(
        title: titleName != null
            ? Text(titleName!)
            : Image.asset(
          'assets/images/logo.png',
          width: 180.0, //MediaQuery.of(context).size.width / 2,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: child,
        ),
      ),
    );
  }
}
