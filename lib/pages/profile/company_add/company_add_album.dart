import 'dart:io';

import 'package:Deal_Connect/components/const/setting_colors.dart';
import 'package:Deal_Connect/components/layout/default_next_layout.dart';
import 'package:Deal_Connect/pages/profile/company_add/company_add_step_one.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CompanyAddAlbum extends StatefulWidget {
  const CompanyAddAlbum({super.key});

  @override
  State<CompanyAddAlbum> createState() => _CompanyAddAlbumState();
}

class _CompanyAddAlbumState extends State<CompanyAddAlbum> {
  File? _pickedImage;
  bool isProcessable = false;
  bool checkState = false;

  @override
  Widget build(BuildContext context) {
    final bottomTextStyle = TextStyle(
      color: Color(0xFF232323),
      fontSize: 14.0,
      //fontWeight: FontWeight.w600
    );

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
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                CompanyAddStepOne(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;

              var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              var offsetAnimation = animation.drive(tween);

              return SlideTransition(position: offsetAnimation, child: child);
            },
          ),
        );
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
          SizedBox(
            height: 40.0,
          ),
          GestureDetector(
            onTap: () {

              showModalBottomSheet(
                backgroundColor: Colors.white,
                showDragHandle: true,
                  context: context,
                  builder: (context) {
                    return SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                                  child: Text('카메라로 촬영', style: bottomTextStyle,),
                                ),
                                onTap: (){
                                  ImagePicker()
                                      .pickImage(source: ImageSource.camera)
                                      .then((xfile) {
                                    if (xfile != null) {
                                      setState(() {
                                        _pickedImage = File(xfile.path);
                                        isProcessable = true;
                                      });
                                    }
                                    Navigator.maybePop(context);
                                  });
                                },
                              ),

                              Divider(height: 1.0, color: Color(0xFFdddddd),),

                              GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                                  child: Text('앨범에서 가져오기', style: bottomTextStyle,),
                                ),
                                onTap: (){
                                  ImagePicker()
                                      .pickImage(source: ImageSource.gallery)
                                      .then((xfile) {
                                    if (xfile != null) {
                                      setState(() {
                                        _pickedImage = File(xfile.path);
                                        isProcessable = true;
                                      });
                                    }
                                    Navigator.maybePop(context);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            },
            child: _pickedImage == null
                ? Container(
                    width: double.infinity,
                    height: 240.0,
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt,
                          color: Color(0xFFD9D9D9),
                          size: 60.0,
                        ),
                        Text(
                          '대표사진을 등록 해주세요',
                          style: TextStyle(color: Color(0xFFA2A2A2)),
                        ),
                      ],
                    ),
                  )
                : Container(
                    width: double.infinity,
                    height: 240.0,
                    child: Image.file(
                      _pickedImage!,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            child: Row(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(20.0),
                  onTap: () {
                    setState(() {
                      checkState = !checkState;
                      if (!checkState) {
                        checkState = false;
                      }
                      isProcessable = checkState || (_pickedImage != null);
                    });
                  },
                  child: _checkType(checkState: checkState),
                ),
                SizedBox(
                  width: 10.0,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      checkState = !checkState;
                      if (!checkState) {
                        checkState = false;
                      }
                      isProcessable = checkState || (_pickedImage != null);
                    });
                  },
                  child: _notImage(
                    underText: '대표사진 다음에 등록하기',
                    checkState: checkState,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _notImage extends StatelessWidget {
  final bool checkState;
  final String underText;

  const _notImage({
    required this.underText,
    required this.checkState,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      underText,
      style: TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.w500,
        color: checkState ? Color(0xFF75A8E4) : Colors.grey,
      ),
    );
  }
}

class _checkType extends StatelessWidget {
  const _checkType({
    Key? key,
    required this.checkState,
  }) : super(key: key);

  final bool checkState;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 26,
      height: 26,
      padding: EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
            color: checkState ? PRIMARY_COLOR : Color(0xFFDDDDDD), width: 2.0),
        color: checkState ? PRIMARY_COLOR : Colors.transparent, // 클릭 시 배경색 변경
      ),
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Icon(
          Icons.check,
          size: 16.0,
          color: checkState ? Colors.white : Color(0xFFDDDDDD),
        ),
      ),
    );
  }
}
