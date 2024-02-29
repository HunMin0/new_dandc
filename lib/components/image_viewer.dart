import 'package:flutter/material.dart';

class ImageViewer extends StatelessWidget {
  final ImageProvider imageProvider;

  ImageViewer({required this.imageProvider});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // 전체 화면 이미지 배경을 검은색으로 설정
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: Image(image: imageProvider), // ImageProvider를 사용하여 이미지를 표시
        ),
      ),
    );
  }
}
