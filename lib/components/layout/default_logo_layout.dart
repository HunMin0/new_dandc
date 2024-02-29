import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Deal_Connect/components/const/setting_colors.dart';
import 'package:hexcolor/hexcolor.dart';

class DefaultLogoLayout extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final String? titleName;
  final String? isNotInnerPadding;
  final bool? rightMoreBtn;

  final bool? rightShareBtn;

  const DefaultLogoLayout(
      {this.titleName,
      required this.child,
      this.backgroundColor,
      this.isNotInnerPadding,
      this.rightMoreBtn = false,
      this.rightShareBtn = false,
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
                  IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
                if (rightShareBtn == true)
                  IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            backgroundColor: Colors.white,
                            showDragHandle: false,
                            context: context,
                            builder: (_) {
                              return Container(
                                width: double.infinity,
                                height: 150,
                                padding: EdgeInsets.only(top: 20.0),
                                color: HexColor("FFFFFF"),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("공유 방법을 선택해주세요."),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Spacer(),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.messenger),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text("문자")
                                            ],
                                          ),
                                          Spacer(),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.messenger),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text("카카오")
                                            ],
                                          ),
                                          Spacer(),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.messenger),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text("뭐시기")
                                            ],
                                          ),
                                          Spacer(),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.messenger),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text("문자")
                                            ],
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
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
    );
  }
}
