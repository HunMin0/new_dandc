import 'package:Deal_Connect/model/group.dart';
import 'package:Deal_Connect/model/group_keyword.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';

class GridGroupCard extends StatelessWidget {
  final Group item;

  const GridGroupCard(
      {required this.item,
        Key? key})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    ImageProvider? backgroundImage;

    if (item.has_group_image != null && item.has_group_image != null) {
      backgroundImage = CachedNetworkImageProvider(
        Utils.getImageFilePath(item.has_group_image!),
      );
    } else {
      backgroundImage = AssetImage('assets/images/no-image.png');
    }

    return Container(
        padding:  const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            color: HexColor("#FFFFFF"),
            borderRadius: BorderRadius.circular(10.0)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
              child: Container(
                child: AspectRatio(
                  aspectRatio: 1.0, // 가로 세로 비율을 1:1로 설정
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: backgroundImage,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5,),
            Text(item.name, style: TextStyle(fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
            SizedBox(height: 10,),
            if (item.has_keywords != null)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal, // 가로 스크롤
                child: _buildTags(item.has_keywords!),
              ),
          ],
        )
    );
  }

// 반복태그
  Widget _buildTags(List<GroupKeyword> tagList) {
    List<Widget> tagWidgets = [];
    for (int i = 0; i < tagList.length; i++) {
      if (i < 3) {
        tagWidgets.add(Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: _cardTag(tagList[i].keyword),
        ));
      } else {
        break;
      }
    }

    return Row(children: tagWidgets);
  }

// 태그 공통
  Container _cardTag(String text) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFf5f6fa),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 7.0),
        child: Text(
          text,
          style: TextStyle(
              color: Color(0xFF5f5f66),
              fontSize: 11.0,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

}

