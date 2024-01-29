import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';


class ImageBuilder extends StatefulWidget {
  final int id;

  const ImageBuilder({required this.id, Key? key}) : super(key: key);

  @override
  State<ImageBuilder> createState() => _ImageBuilderState();
}

class _ImageBuilderState extends State<ImageBuilder> {
  final List<String> imageAssetPaths = [
    'assets/images/image-1.jpg',
    'assets/images/image-2.jpg',
    'assets/images/image-3.jpg',
    'assets/images/image-4.jpg',
    'assets/images/image-5.jpg',
    // Add more image paths as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: CarouselSlider(
            items: imageAssetPaths.map((assetPath) {
              return Image.asset(
                assetPath,
                fit: BoxFit.cover,
              );
            }).toList(),
            options: CarouselOptions(
              height: 200.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              onPageChanged: (index, reason) {
                // 페이지 변경 시 호출되는 콜백
              },
            ),
          ),
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            imageAssetPaths.length,
                (index) => buildDot(index),
          ),
        ),
        SizedBox(height: 16.0),
      ],
    );
  }

  Widget buildDot(int index) {
    return Container(
      width: 8.0,
      height: 8.0,
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: index == 0 ? Colors.blue : Colors.grey, // 선택된 페이지를 강조
      ),
    );
  }
}