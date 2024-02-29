import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:Deal_Connect/components/const/setting_colors.dart';

class SliverLayout extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final String? isNotInnerPadding;
  final bool? rightMoreBtn;

  final bool isNext;
  final bool isCancel;
  final bool bottomBar;
  final bool? isProcessable;
  final String? nextTitle;
  final String? prevTitle;
  final VoidCallback? nextOnPressed;
  final VoidCallback? prevOnPressed;

  const SliverLayout({
    required this.child,
    this.backgroundColor,
    this.isNotInnerPadding,
    this.isNext = false,
    this.isCancel = false,
    this.bottomBar = false,
    this.isProcessable,
    this.nextTitle,
    this.prevTitle,
    this.nextOnPressed,
    this.prevOnPressed,
    this.rightMoreBtn = false,

    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? SettingColors.primaryMeterialColor,
      body: SafeArea(
        child: Padding(
          padding: isNotInnerPadding == 'true' ? const EdgeInsets.all(0.0) : const EdgeInsets.all(20.0),
          child: child,
        ),
      ),
      bottomNavigationBar: bottomBar
          ? BottomButtons(
        isNext: isNext,
        isCancel: isCancel,
        isProcessable: isProcessable!,
        nextOnPressed: nextOnPressed!,
        prevOnPressed: prevOnPressed!,
        nextTitle: nextTitle!,
        prevTitle: prevTitle!,
      )
          : null,
    );
  }
}



class BottomButtons extends StatelessWidget {
  final bool isProcessable;
  final String nextTitle;
  final String prevTitle;
  final VoidCallback? nextOnPressed;
  final VoidCallback prevOnPressed;
  final bool isCancel;
  final bool isNext;

  const BottomButtons(
      {required this.nextOnPressed,
        required this.prevOnPressed,
        required this.nextTitle,
        required this.prevTitle,
        required this.isProcessable,
        required this.isCancel,
        required this.isNext,
        super.key});

  @override
  Widget build(BuildContext context) {
    final boxStyle = ElevatedButton.styleFrom(
      backgroundColor: Color(0xFFF5F6FA),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      elevation: 0,
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0),
    );
    final boxDisble = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      elevation: 0,
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0),
    );
    final textStyle = TextStyle(
      color: Color(0xFF666666),
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
    );

    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(left:16.0, right:16.0, bottom:16.0),
          child: Row(
            children: [
              if (isCancel)
                ElevatedButton(
                  style: boxStyle,
                  onPressed: prevOnPressed,
                  child: Text(
                    prevTitle,
                    style: textStyle,
                  ),
                ),
              if (isCancel)
                SizedBox(
                  width: 10.0,
                ),
              if (isNext)
                Expanded(
                  child: ElevatedButton(
                    style: isProcessable
                        ? boxStyle.copyWith(
                        backgroundColor:
                        MaterialStateProperty.all(Color(0xFF75A8E4)))
                        : boxDisble,
                    onPressed: isProcessable ? nextOnPressed : null,
                    child: Text(
                      nextTitle,
                      style: textStyle.copyWith(color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        )
      ],
    );
  }
}
