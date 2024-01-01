import 'package:flutter/material.dart';
import 'package:Deal_Connect/components/const/setting_colors.dart';

class DefaultBasicLayout extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;

  const DefaultBasicLayout({required this.child, this.backgroundColor, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? SettingColors.primaryMeterialColor,
      body: SafeArea(
        child: child,
      ),
    );
  }
}
