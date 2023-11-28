import 'package:Deal_Connect/Utils/custom_dialog.dart';
import 'package:Deal_Connect/api/auth.dart';
import 'package:Deal_Connect/components/custom/custom_text_form_field.dart';
import 'package:Deal_Connect/model/login_response_data.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class EmailLogin extends StatefulWidget{
  @override
  EmailLoginState createState() => new EmailLoginState();
}

class EmailLoginState extends State<EmailLogin>{
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
      body: _EmailLoginForm(context),
    );
  }

  SafeArea _EmailLoginForm(BuildContext context) {
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 14,
    );

    return SafeArea(
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 0, bottom: 20.0),
                    child: Text(
                      '이메일 로그인',
                      style: textStyle.copyWith(
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                  Text(
                    'Deal+Connect 서비스 이용을 위하여 회원님의\n이메일 계정정보를 입력 해주세요',
                    style: textStyle,
                  ),
                  SizedBox(height: 40.0,),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      child: LoginTextFormField(
                        icon: Icons.email,
                        labelText: '이메일 주소를 입력하세요',
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),
                    ),
                  ),
                  Container(
                    child: LoginTextFormField(
                      icon: Icons.lock,
                      labelText: '비밀번호를 입력하세요',
                      isPassword: true,
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
                  child: const Text('로그인',style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}