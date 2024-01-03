import 'package:Deal_Connect/components/const/setting_colors.dart';
import 'package:flutter/material.dart';

class DefaultNextLayout extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final String? titleName;

  final bool bottomBar;
  final bool isProcessable;
  final String? nextTitle;
  final String? prevTitle;
  final VoidCallback? nextOnPressed;
  final VoidCallback? prevOnPressed;

  const DefaultNextLayout(
      {this.titleName,
      required this.child,
      required this.isProcessable,
      this.backgroundColor,
      required this.bottomBar,
      this.prevTitle,
      this.nextTitle,
      this.prevOnPressed,
      this.nextOnPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? SettingColors.primaryMeterialColor,
      appBar: AppBar(
        title: titleName != null
            ? Text(
                titleName!,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
              )
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
          padding: const EdgeInsets.all(20.0),
          child: child,
        ),
      ),
      bottomNavigationBar: bottomBar
          ? BottomButtons(
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

  const BottomButtons(
      {required this.nextOnPressed,
      required this.prevOnPressed,
      required this.nextTitle,
      required this.prevTitle,
      required this.isProcessable,
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
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              ElevatedButton(
                style: boxStyle,
                onPressed: prevOnPressed,
                child: Text(
                  prevTitle,
                  style: textStyle,
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: ElevatedButton(
                  style: isProcessable ? boxStyle.copyWith(backgroundColor: MaterialStateProperty.all(Color(0xFF75A8E4)))
                  : boxDisble,
                  onPressed: isProcessable ? nextOnPressed : null,
                  child: Text(nextTitle, style: textStyle.copyWith(color: Colors.white),),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  test() {}
}
