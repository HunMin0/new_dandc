import 'dart:convert';

import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/model/response_data.dart';

// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class CustomDialog {
  static bool isProgress = false;
  static ProgressDialog? pd;

  static showShareDialog(BuildContext context, String title, String url) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        showDragHandle: false,
        context: context,
        builder: (_) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: Container(
              width: double.infinity,
              height: 230,
              padding: EdgeInsets.only(bottom: 20.0),
              decoration: BoxDecoration(
                color: HexColor("FFFFFF"),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 15.0),
                    child: Row(
                      children: [
                        Text("공유하기",
                            style: SettingStyle.NORMAL_TEXT_STYLE
                                .copyWith(fontWeight: FontWeight.bold)),
                        Spacer(),
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              CupertinoIcons.xmark,
                              color: HexColor("#222222"),
                              size: 25,
                            )),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    height: 1,
                    color: HexColor("#DDDDDD"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Spacer(),
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   children: [
                        //     Container(
                        //       width: 50,
                        //       height: 50,
                        //       decoration: BoxDecoration(
                        //         color: HexColor("#FEE500"),
                        //         borderRadius:
                        //             BorderRadius.all(Radius.circular(50)),
                        //       ),
                        //       child: Icon(
                        //         CupertinoIcons.chat_bubble_fill,
                        //         color: HexColor("#222222"),
                        //         size: 30,
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       height: 10,
                        //     ),
                        //     Text("카카오톡")
                        //   ],
                        // ),
                        // Spacer(),
                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: url)).then((_) {
                              Fluttertoast.showToast(msg: '복사되었습니다.');
                            });
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: SettingStyle.GREY_COLOR,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                  ),
                                  child: Icon(
                                    CupertinoIcons.link,
                                    color: HexColor("#222222"),
                                    size: 30,
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Text("URL 복사")
                            ],
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            Share.share(url, subject: url);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: SettingStyle.GREY_COLOR,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                  ),
                                  child: Icon(
                                    CupertinoIcons.ellipsis,
                                    color: HexColor("#222222"),
                                    size: 30,
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Text("더보기")
                            ],
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  static showLoaderDialog(BuildContext context, String msg) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          const CircularProgressIndicator(),
          Container(
            margin: const EdgeInsets.only(left: 7),
            child: Text(msg != null ? msg : "Loading..."),
          )
        ],
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showCustomDialog({
    required BuildContext context,
    required String title,
    required String msg,
  }) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      title: title != null && title.isNotEmpty
          ? Column(
              children: <Widget>[
                new Text(title),
              ],
            )
          : Container(),
      //
      content: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              msg,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        new TextButton(
          child: new Text("확인"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showLoginDialog({
    required BuildContext context,
    required VoidCallback onLoginBtnClick,
  }) {
    showDoubleBtnDialog(
        context: context,
        msg: '해당 기능은 로그인 후 사용 가능합니다.\n로그인 하시겠습니까?',
        leftBtnText: "취소",
        rightBtnText: "확인",
        onLeftBtnClick: () {},
        onRightBtnClick: onLoginBtnClick);
  }

  static showDoubleBtnDialog({
    required BuildContext context,
    String? title,
    required String msg,
    String? leftBtnText,
    String? rightBtnText,
    required VoidCallback onLeftBtnClick,
    required VoidCallback onRightBtnClick,
  }) {
    AlertDialog alert = AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      title: title != null && title.isNotEmpty
          ? Column(
              children: <Widget>[
                new Text(title),
              ],
            )
          : Container(),
      content: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 20),
              child: Text(
                msg,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis
                ),
              ),
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: () {
                        onLeftBtnClick();
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border(
                          top: BorderSide(
                            color: HexColor('#d8d8db'),
                          ),
                          right: BorderSide(
                            color: HexColor('#d8d8db'),
                          ),
                        )),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          leftBtnText != null && leftBtnText.isNotEmpty
                              ? leftBtnText
                              : '닫기',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: HexColor('#acacac'),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: () {
                        onRightBtnClick();
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border(
                          top: BorderSide(
                            color: HexColor('#d8d8db'),
                          ),
                        )),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          rightBtnText != null && rightBtnText.isNotEmpty
                              ? rightBtnText
                              : '닫기',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: HexColor('#355ebd'),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static getThumbnailChangeDialog(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      title: Column(
        children: <Widget>[
          new Text("이미지 수정"),
        ],
      ),
      //
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "해당 이미지의 편집/삭제 여부를 선택해주세요.",
          ),
        ],
      ),
      actions: <Widget>[
        new TextButton(
          child: new Text("편집"),
          onPressed: () {
            Navigator.pop(context, "edit");
          },
        ),
        new TextButton(
          child: new Text("삭제"),
          onPressed: () {
            Navigator.pop(context, "remove");
          },
        )
      ],
    );
  }

  static closeDialog(BuildContext context) {
    Navigator.pop(context);
  }

  static showProgressDialog(BuildContext context) {
    ProgressDialog pd = ProgressDialog(context: context);

    CustomDialog.pd = pd;
    CustomDialog.isProgress = true;

    pd.show(
      max: 100,
      msg: '잠시만 기다려주세요.',
      barrierDismissible: true,
      barrierColor: const Color(0x44000000),
    );
  }

  static dismissProgressDialog() {
    CustomDialog.isProgress = false;
    if (CustomDialog.pd != null) {
      CustomDialog.pd!.close();
    }
  }

  static showServerValidatorErrorMsg(ResponseData response) {
    try {
      print('response.statusCode: ${response.statusCode}');
      if (response.statusCode == 405) {
        Fluttertoast.showToast(msg: '이미 탈퇴한 계정입니다.');
      } else if (response.statusCode == 412) {
        Map message = jsonDecode(response.message) as Map;
        String firstErrorKey = message.keys.elementAt(0);
        String firstErrorMessage = message[firstErrorKey][0];
        Fluttertoast.showToast(msg: firstErrorMessage);
      } else if (response.statusCode == 422) {
        Fluttertoast.showToast(msg: '비밀번호가 일치하지 않습니다.');
      } else if (response.statusCode == 423) {
        Fluttertoast.showToast(msg: '인증번호가 다릅니다.');
      } else if (response.statusCode == 426) {
        Fluttertoast.showToast(msg: '일치하는 사용자 계정이 없습니다.');
      } else if (response.statusCode == 427) {
        //Fluttertoast.showToast(msg: '토큰이 만료되었습니다.');
      } else {
        Fluttertoast.showToast(msg: response.message);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
