import 'dart:io';

class ImagePickerItem {
  int index;
  File imgFile;
  List<int> resizedImage;
  String resizedImageName;

  ImagePickerItem({
    this.index = 0,
    required this.imgFile,
    required this.resizedImage,
    required this.resizedImageName,
  });
}