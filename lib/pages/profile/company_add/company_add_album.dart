import 'dart:io';

import 'package:Deal_Connect/components/layout/default_next_layout.dart';
import 'package:flutter/material.dart';

class CompanyAddAlbum extends StatelessWidget {
  const CompanyAddAlbum({super.key});

  @override
  Widget build(BuildContext context) {
    bool isProcessable = false;
    File? _pickedImage;

    return DefaultNextLayout(
      titleName: '업체등록',
      isProcessable: isProcessable,
      bottomBar: true,
      prevTitle: '취소',
      nextTitle: '다음',
      prevOnPressed: () {
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
      nextOnPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CompanyAddAlbum()));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('사업장 대표사진을 등록해주세요',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              )),
          SizedBox(height: 50.0,),
          GestureDetector(
            child: Container(
              width: double.infinity,
              height: 240.0,
              decoration: BoxDecoration(
                color: Colors.black,
              ),
            ),
            onTap: (){
              showModalBottomSheet(context: context, builder: (context){
                return Column(
                  children: [
                    TextButton(onPressed: (){

                    }, child: Text('카메라로 촬영'),),
                    TextButton(onPressed: (){

                    }, child: Text('앨범에서 가져오기'),),
                  ],
                );
              });
            },
          ),
        ],
      ),
    );
  }
}
