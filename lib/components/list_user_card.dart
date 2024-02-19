import 'package:Deal_Connect/model/user.dart';
import 'package:Deal_Connect/model/user_keyword.dart';
import 'package:Deal_Connect/model/user_profile.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ListUserCard extends StatelessWidget {
  final User item;

  const ListUserCard({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ImageProvider? profileThumbnailImage =
    AssetImage('assets/images/no-image.png');
    ImageProvider? businessThumbnailImage =
    AssetImage('assets/images/no-image.png');

    if (item.has_user_profile?.has_profile_image != null) {
      final profileImage = item.has_user_profile!.has_profile_image!;
      profileThumbnailImage = CachedNetworkImageProvider(
        Utils.getImageFilePath(profileImage),
      );
    }

    if (item.main_business?.has_business_image != null) {
      final businessImage =
      item.main_business!.has_business_image!;
      businessThumbnailImage = CachedNetworkImageProvider(
        Utils.getImageFilePath(businessImage),
      );
    }


    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/profile', arguments: { 'user_id': item.id });
      },
      child: Container(
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
              Stack(
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
              ),
              SizedBox(
                width: 18.0,
              ),
              _ListRightText(),
            ],
          ),
        ),
      ),
    );
  }

  Expanded _ListRightText() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item.name,
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 16.0),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            item.main_business != null ? item.main_business!.name : '',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
                color: Color(0xFF8c8c8c)),
          ),
          SizedBox(
            height: 5.0,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal, // 가로 스크롤
            child: _buildTags(item.has_keywords as List<UserKeyword>),
          ),
        ],
      ),
    );
  }


  // 반복태그
  Widget _buildTags(List<UserKeyword> tagList) {
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
