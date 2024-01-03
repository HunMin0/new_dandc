import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/*
    ios->runner->info.plist
    https://adbrdev.notion.site/CH02-640a86b47d704e5b9fb56f871d87efa2#6469864d3b05456894a039d61e2dbe99
   iOS 기기 권한 요청 메세지를 그대로 작성할 경우, 앱스토어 심사에서 거절을 당함,
     테스트 후 변경된 문자열로 수정필요

 */

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Conainer',
        ),
      ),
      body: CustomConainer(),
    ),
  ));
}

class CustomConainer extends StatefulWidget {
  const CustomConainer({super.key});

  @override
  State<CustomConainer> createState() => _CustomConainerState();
}

class _CustomConainerState extends State<CustomConainer> {
  File? _pickedImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100,
        ),
        Center(
          child: CircleAvatar(
            backgroundColor: Colors.indigo,
            radius: 40,
            child: CupertinoButton(
              padding: _pickedImage == null ? null : EdgeInsets.zero,
              onPressed: () {

                showModalBottomSheet(context: context, builder: (context){
                  return SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(onPressed: (){
                            ImagePicker()
                                .pickImage(source: ImageSource.camera)
                                .then((xfile) {
                              if (xfile != null) {
                                setState(() {
                                  _pickedImage = File(xfile.path);
                                });
                              }
                              Navigator.maybePop(context);
                            });
                          }, child: Text('카메라로 촬영'),),
                          TextButton(onPressed: (){
                            ImagePicker()
                                .pickImage(source: ImageSource.gallery)
                                .then((xfile) {
                              if (xfile != null) {
                                setState(() {
                                  _pickedImage = File(xfile.path);
                                });
                              }
                              Navigator.maybePop(context);
                            });
                          }, child: Text('앨범에서 가져오기'),),
                        ],
                      ),
                    ),
                  );
                });


              },
              child: _pickedImage == null
                  ? Icon(
                CupertinoIcons.photo_camera_solid,
                size: 30,
                color: Colors.white,
              )
                  : CircleAvatar(
                radius: 40,
                foregroundImage: FileImage(_pickedImage!),
              ),
            ),
          ),
        )
      ],
    );
  }
}