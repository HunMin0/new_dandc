import 'package:Deal_Connect/components/common_item/color_chip.dart';
import 'package:Deal_Connect/components/common_item/grey_chip.dart';
import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:Deal_Connect/model/group_keyword.dart';
import 'package:Deal_Connect/model/group_user.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ListGroupCard extends StatelessWidget {
  final GroupUser item;

  const ListGroupCard({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ImageProvider? backgroundImage;

    if (item.has_group!.has_group_image != null &&
        item.has_group!.has_group_image != null) {
      backgroundImage = CachedNetworkImageProvider(
        Utils.getImageFilePath(item.has_group!.has_group_image!),
      );
    } else {
      backgroundImage = const AssetImage('assets/images/no-image.png');
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: backgroundImage,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            const SizedBox(
              width: 18.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      if (item.is_approved == false) ...[
                        ColorChip(
                            chipText: '승인대기',
                            color: HexColor("#aaaaaa"),
                            textColor: HexColor("#ffffff")),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                      Text(item.has_group!.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                          )),
                      Spacer(),
                      if (item.is_leader == true)
                        Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFf5f6fa),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 7.0),
                              child: Text(
                                "내 그룹",
                                style: TextStyle(
                                    color: Color(0xFF5f5f66),
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                        )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  if (item.approved_at != null)
                    Text(
                      "가입일자 " + item.approved_at!.substring(0, 11) ?? '',
                      style: SettingStyle.SUB_GREY_TEXT,
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      _buildTags(item.has_group!.has_keywords!),
                    ],
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 반복태그
  Widget _buildTags(List<GroupKeyword> tagList) {
    List<Widget> tagWidgets = [];
    for (int i = 0; i < tagList.length; i++) {
      if (i < 3) {
        tagWidgets.add(Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: GreyChip(chipText: '#' + tagList[i].keyword),
        ));
      } else {
        break;
      }
    }

    return Row(children: tagWidgets);
  }
}
