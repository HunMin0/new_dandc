import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Deal_Connect/components/const/setting_colors.dart';

class DefaultLogoLayout extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final String? titleName;
  final String? isNotInnerPadding;
  final bool? rightMoreBtn;

  final bool? rightShareBtn;
  final VoidCallback? rightMoreAction;
  final VoidCallback? rightShareAction;

  const DefaultLogoLayout(
      {this.titleName,
      required this.child,
      this.backgroundColor,
      this.isNotInnerPadding,
      this.rightShareAction,
      this.rightMoreAction,
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
                    IconButton(onPressed: () {
                      rightMoreAction!();
                    }, icon: Icon(CupertinoIcons.ellipsis_vertical)),
                  if (rightShareBtn == true)
                    IconButton(
                        onPressed: () {
                          rightShareAction!();
                        },
                        icon: Icon(CupertinoIcons.share)),
                ]
              : null,
          /*
          actions: [
            IconButton(
                onPressed: (){},
                icon: Icon(Icons.more_horiz),
            ),
          ],
          */
        ),
        body: SafeArea(
          child: Padding(
            padding: isNotInnerPadding == 'true'
                ? const EdgeInsets.all(0.0)
                : const EdgeInsets.all(20.0),
            child: child,
          ),
        ),
      ),
    );
  }
}
