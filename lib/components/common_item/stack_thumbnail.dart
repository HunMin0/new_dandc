import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StackThumbNail extends StatelessWidget {
  ImageProvider businessThumbnailImage;
  ImageProvider profileThumbnailImage;

  StackThumbNail({required this.profileThumbnailImage, required this.businessThumbnailImage, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      //overflow: Overflow.visible,
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: businessThumbnailImage,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          right: -8.0,
          bottom: -8.0,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 2.0,
              ),
            ),
            child: CircleAvatar(
              radius: 18.0,
              backgroundImage: profileThumbnailImage,
            ),
          ),
        ),
      ],
    );
  }
}
