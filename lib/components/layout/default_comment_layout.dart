import 'package:Deal_Connect/components/const/setting_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class DefaultCommentLayout extends StatelessWidget {
  final Widget child;
  final Widget bottomWidget;
  final Color? backgroundColor;
  final String? titleName;
  final String? isNotInnerPadding;
  final bool? rightMoreBtn;

  final bool? rightShareBtn;
  final VoidCallback? rightMoreAction;
  final VoidCallback? rightShareAction;
  final ImageProvider avatarImageProvider;

  const DefaultCommentLayout(
      {this.titleName,
      required this.child,
      required this.bottomWidget,
      this.backgroundColor,
      this.isNotInnerPadding,
      this.rightShareAction,
      this.rightMoreAction,
      required this.avatarImageProvider,
      this.rightMoreBtn = false,
      this.rightShareBtn = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
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
            leading: IconButton(
              icon: Icon(CupertinoIcons.back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white,
            actions: (rightMoreBtn == true || rightShareBtn == true)
                ? [
                    if (rightMoreBtn == true)
                      IconButton(
                          onPressed: () {
                            rightMoreAction!();
                          },
                          icon: Icon(CupertinoIcons.ellipsis_vertical)),
                    if (rightShareBtn == true)
                      IconButton(
                          onPressed: () {
                            rightShareAction!();
                          },
                          icon: Icon(CupertinoIcons.share)),
                  ]
                : null,
          ),
          body: SafeArea(
            child: Container(
              padding: isNotInnerPadding == 'true'
                  ? const EdgeInsets.all(0.0)
                  : const EdgeInsets.all(20.0),
              child: child,
            ),
          ),
          bottomSheet: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                  color: HexColor("#ffffff"),
                  border: Border(
                    top: BorderSide(color: HexColor("#dddddd"), width: 1.0),
                  )),
              padding: EdgeInsets.only(top: 10),
              child: bottomWidget,
            ),
          )),
    );
  }
}
