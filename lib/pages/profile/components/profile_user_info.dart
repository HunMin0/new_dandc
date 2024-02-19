import 'package:Deal_Connect/model/user_keyword.dart';
import 'package:Deal_Connect/model/user_profile.dart';
import 'package:Deal_Connect/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:hexcolor/hexcolor.dart';

class ProfileUserInfo extends StatelessWidget {
  final String userName;
  final List<UserKeyword>? hasUserKeywords;
  final UserProfile? hasUserProfile;

  const ProfileUserInfo(
      {required this.userName,
      this.hasUserKeywords,
      this.hasUserProfile,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ImageProvider? backgroundImage;
    if (hasUserProfile != null && hasUserProfile!.has_profile_image != null) {
      backgroundImage = CachedNetworkImageProvider(
        Utils.getImageFilePath(hasUserProfile!.has_profile_image!),
      );
    } else {
      backgroundImage = AssetImage('assets/images/no-image.png');
    }
    return Row(
      children: [
        CircleAvatar(
          radius: 34.0,
          backgroundImage: backgroundImage,
        ),
        SizedBox(
          width: 18.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              if (hasUserKeywords != null)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: _buildTags(hasUserKeywords!),
                )
            ],
          ),
        ),
        GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, '/profile/edit');

          },
          child: Icon(
            Icons.edit_note,
            color: HexColor("#dddddd"),
            size: 30,
          ),
        ),
        SizedBox(
          width: 10,
        )
      ],
    );
  }

  // 반복태그
  Widget _buildTags(List<UserKeyword> tagList) {
    List<Widget> tagWidgets = [];
    for (int i = 0; i < tagList.length; i++) {
      if (i < 3) {
        // 최대 3개 태그만 표시
        tagWidgets.add(Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: _cardTag(
              tagList[i] as UserKeyword), // tagList[i]는 Map<String, dynamic> 타입
        ));
      } else {
        break;
      }
    }

    return Row(children: tagWidgets);
  }

  // 태그 공통
  Container _cardTag(UserKeyword text) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFf5f6fa),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 7.0),
        child: Text(
          '#' + text.keyword,
          style: TextStyle(
              color: Color(0xFF5f5f66),
              fontSize: 11.0,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
