import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:flutter/material.dart';

class TermsOfUse extends StatelessWidget {
  const TermsOfUse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String title = '제1조(목적)';
    final String subject = '이 약관은 OO 회사(전자상거래 사업자)가 운영하는 OO 사이버 몰(이하 “몰”이라 한다)에서 제공하는 인터넷 관련 서비스(이하 “서비스”라 한다)를 이용함에 있어 사이버 몰과 이용자의 권리․의무 및 책임사항을 규정함을 목적으로 합니다. ※「PC통신, 무선 등을 이용하는 전자상거래에 대해서도 그 성질에 반하지 않는 한 이 약관을 준용합니다.';

    return DefaultLogoLayout(
      titleName: '이용약관',
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16.0,),),
            SizedBox(height: 10.0,),
            Text(subject),
            SizedBox(height: 20.0,),
            Text(title, style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16.0,),),
            SizedBox(height: 10.0,),
            Text(subject),
            SizedBox(height: 20.0,),
            Text(title, style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16.0,),),
            SizedBox(height: 10.0,),
            Text(subject),
            SizedBox(height: 20.0,),
            Text(title, style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16.0,),),
            SizedBox(height: 10.0,),
            Text(subject),
            SizedBox(height: 20.0,),
          ],
        ),
      ),
    );
  }
}
