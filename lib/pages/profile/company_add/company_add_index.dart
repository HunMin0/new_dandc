import 'package:Deal_Connect/api/categories.dart';
import 'package:Deal_Connect/db/sector_type.dart';
import 'package:Deal_Connect/components/layout/default_next_layout.dart';
import 'package:Deal_Connect/model/category.dart';
import 'package:Deal_Connect/pages/profile/company_add/company_add_album.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CompanyAddIndex extends StatefulWidget {
  const CompanyAddIndex({super.key});

  @override
  State<CompanyAddIndex> createState() => _CompanyAddIndexState();
}

class _CompanyAddIndexState extends State<CompanyAddIndex> {
  int selectedIdx = -1;
  bool isProcessable = true; // 작업종료후 false
  String selectedSectorName = "";
  List<Category>? categories;

  @override
  void initState() {
    getCategories().then((response) {
      if (response.status == 'success') {
        Iterable iterable = response.data;
        List<Category> list = List<Category>.from(iterable.map((e) => Category.fromJSON(e)));

        setState(() {
          categories = list;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 17.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    );

    return DefaultNextLayout(
      titleName: '업체등록',
      isProcessable: isProcessable,
      bottomBar: true,
      prevTitle: '취소',
      nextTitle: '다음',
      prevOnPressed: () {
        Navigator.of(context).pop();
      },
      nextOnPressed: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                CompanyAddAlbum(),
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
          selectedSectorName.isEmpty
              ? Text(
                  '업종을 선택해주세요',
                  style: textStyle,
                )
              : RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: '선택하신 업종은 ',
                      style: textStyle.copyWith(),
                    ),
                    TextSpan(
                      text: selectedSectorName,
                      style: textStyle.copyWith(
                        color: Color(0xFF75A8E4),
                      ),
                    ),
                    TextSpan(
                      text: '업 입니다.',
                      style: textStyle,
                    ),
                  ]),
                ),
          SizedBox(
            height: 40.0,
          ),
          Expanded(
            child: _buildGridView(),
          ),
        ],
      ),
    );
  }

  GridView _buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 20.0,
      mainAxisSpacing: 20.0,
      children: categories != null ?
          categories!.map((item){

            Widget thumbnailImage = Image.asset(
              'assets/images/camera_icon.png',
              width: 55,
              height: 55,
              fit: BoxFit.cover,
            );

            if (item.has_category_icon_image != null) {
              thumbnailImage = CachedNetworkImage(
                imageUrl: Utils.getImageFilePath(item.has_category_icon_image!),
                placeholder: (context, url) => new CircularProgressIndicator(),
                errorWidget: (context, url, error) => new Icon(Icons.error),
              );
            }
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (selectedIdx == item.id) {
                    // 이미 선택된 아이템을 다시 탭하면 선택 해제
                    selectedIdx = -1;
                    selectedSectorName = "";
                    isProcessable = false;
                  } else {
                    // 새로운 아이템 선택
                    selectedIdx = item.id;
                    selectedSectorName = item.name;
                    isProcessable = true;
                  }
                });
              },
              child: Container(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 6.0),
                      width: 70.0,
                      height: 70.0,
                      child:ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: thumbnailImage,
                        ),
                      ),
                    ),
                    Text(
                      item.name,
                      style: TextStyle(
                          color: selectedIdx == item.id
                              ? Color(0xFF75A8E4)
                              : Colors.black),
                    ),
                  ],
                ),
              ),
            );
          }).toList()
      : []
    );
  }
}
