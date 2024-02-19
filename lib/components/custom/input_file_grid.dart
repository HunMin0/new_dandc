import 'dart:io';

import 'package:Deal_Connect/utils/custom_dialog.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:Deal_Connect/items/image_picker_item.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image/image.dart' as IMG;
import 'package:path/path.dart';

class InputFileGrid extends StatefulWidget {
  List<ImagePickerItem> imageList;
  List<File>? beforeFileList;

  bool isAddable = true;
  bool isOnlyImage = true;

  InputFileGrid({Key? key,
    required this.imageList,
    this.beforeFileList,
    this.isAddable = true,
    this.isOnlyImage = true,
  }) : super(key: key);

  @override
  InputFileGridState createState() => new InputFileGridState(imageList: imageList, isAddable: isAddable, isOnlyImage: isOnlyImage);
}

class InputFileGridState extends State<InputFileGrid> {
  List<ImagePickerItem> imageList;
  bool isAddable = true;
  bool isOnlyImage = true;

  InputFileGridState({
    required this.imageList,
    this.isAddable = true,
    this.isOnlyImage = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            primary: true,
            crossAxisSpacing: 5,
            mainAxisSpacing: 10,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(imageList.length > 0 ? imageList.length : 1, (index) {
              return TextButton(
                onPressed: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles(
                    type: isOnlyImage ? FileType.image : FileType.any
                  );

                  if(result != null) {
                    String? path = result.files.single.path;
                    if (path != null) {
                      File file = File(path);
                      List<int> encodeResizedImage = Utils.encodeResizedImage(path);
                      setState(() {
                        imageList.removeWhere((item) => item.index == index);

                        imageList.add(ImagePickerItem(
                          index: index,
                          imgFile: file,
                          resizedImage: encodeResizedImage,
                          resizedImageName: basename(path),
                        ));
                      });
                    }
                  }
                },
                onLongPress: () {
                  if (imageList.where((item) => index == item.index).isNotEmpty) {
                    CustomDialog.showDoubleBtnDialog(
                      context: context,
                      msg: "해당 사진을 삭제하시겠습니까?",
                      leftBtnText: "취소",
                      rightBtnText: "확인",
                      onLeftBtnClick: () {},
                      onRightBtnClick: () {
                        setState(() {
                          imageList.removeWhere((item) => item.index == index);

                          for (var item in imageList) {
                            int index = imageList.indexOf(item);
                            item.index = index;
                          }
                        });
                      },
                    );
                  }
                },
                child: AspectRatio(
                  aspectRatio: 310/326,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: HexColor('#a3a3a3'),
                        )
                    ),
                    child: imageList.where((item) => index == item.index).isNotEmpty ? Image.file(
                      imageList.where((item) => index == item.index).first.imgFile,
                      fit: BoxFit.cover,
                    ) : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 5),
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: Image.asset('assets/images/camera_icon.png', fit: BoxFit.contain),
                          ),
                        ),
                        Text(
                          '사진등록',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: HexColor('#a3a3a3'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              );
            }),
          ),
          isAddable ?
          TextButton(
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type : isOnlyImage ? FileType.image : FileType.any,
              );

              if(result != null) {
                String? path = result.files.single.path;

                if (path != null) {
                  File file = File(path);
                  List<int> encodeResizedImage = Utils.encodeResizedImage(path);

                  setState(() {
                    imageList.add(ImagePickerItem(
                      index: imageList.length,
                      imgFile: file,
                      resizedImage: encodeResizedImage,
                      resizedImageName: basename(path),
                    ));
                  });
                }
              }
            },
            child: Text(
              '추가하기 +',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: HexColor('#a6a6a6'),
              ),
            ),
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          )
              :
          Container(),
        ],
      ),
    );
  }
}