import 'package:DealConnect/Utils/custom_dialog.dart';
import 'package:DealConnect/Utils/shared_pref_utils.dart';
import 'package:DealConnect/api/auth.dart';
import 'package:DealConnect/model/login_response_data.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

class EmailLoginPage extends StatefulWidget{
  @override
  EmailLoginPageState createState() => new EmailLoginPageState();
}

class EmailLoginPageState extends State<EmailLoginPage>{
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      backgroundColor: HexColor('#75a8e4'),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 0, bottom: 20),
                    child: const Text(
                      '이메일 로그인',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30
                      ),
                    ),
                  ),
                  const Text(
                    'Deal+Connect 서비스 이용을 위하여 회원님의',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 40),
                    child: const Text(
                      '이메일 계정정보를 입력 해주세요',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: TextField(
                      style: TextStyle(
                          color: Colors.white
                      ),
                      decoration: const InputDecoration(
                        labelText: '이메일 주소를 입력하세요',
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        prefixIconConstraints:BoxConstraints(minWidth: 10, maxHeight: 25),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                          child: Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                  ),
                  Container(
                    child: TextField(
                      style: TextStyle(
                          color: Colors.white
                      ),
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: '비밀번호를 입력하세요',
                        labelStyle: TextStyle(color: Colors.white),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        prefixIconConstraints:BoxConstraints(minWidth: 10, maxHeight: 25),
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                          child: Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                child: ElevatedButton(
                  onPressed: () {
                    CustomDialog.showProgressDialog(context);

                    postLogin({
                      'email': email,
                      'password': password
                    }).then((value) {
                      CustomDialog.dismissProgressDialog();

                      if (value.status == 'success') {
                        LoginResponseData loginResponseData = LoginResponseData.fromJSON(value.data);

                        initLoginUserData(
                            loginResponseData.user,
                            loginResponseData.tokenType,
                            loginResponseData.accessToken
                        ).then((result) {
                          Navigator.pushNamedAndRemoveUntil(context, '/home', (r) => false);
                        });
                      } else {
                        CustomDialog.showServerValidatorErrorMsg(value);
                      }
                    });
                  },
                  child: const Text('로그인'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}