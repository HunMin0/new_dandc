import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:Deal_Connect/components/layout/default_next_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class BusinessServiceInfo extends StatefulWidget {
  const BusinessServiceInfo({super.key});

  @override
  State<BusinessServiceInfo> createState() => _BusinessServiceInfoState();
}

class _BusinessServiceInfoState extends State<BusinessServiceInfo> {
  @override
  Widget build(BuildContext context) {
    return DefaultNextLayout(
      titleName: '청년 한다발 서초점',
      nextTitle: '수정',
      prevTitle: '삭제',
      isCancel: true,
      isProcessable: true,
      bottomBar: true,
      nextOnPressed: (){Navigator.pop(context);},
      prevOnPressed: (){},
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("꽃 바구니", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),  ),
            SizedBox(height: 10.0,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Image(
                    image: AssetImage('assets/images/sample/main_sample01.jpg'),
                  ),
                ),
                SizedBox(height: 10,),
                Text('삼겹살 같은 꽃이 한아름!')
              ],
            ),
          ],
        ),
      ),
    );
  }
}
