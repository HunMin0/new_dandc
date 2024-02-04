import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';

class ListNoticeCard extends StatelessWidget {
  final String title;
  final String created_at;
  final String profile_img;

  const ListNoticeCard(
      {required this.title,
        required this.created_at,
        required this.profile_img,
        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: HexColor("#ffffff"),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(profile_img),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,),
                      Text(created_at, style: SettingStyle.SUB_GREY_TEXT,)
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 40,)
      ],
    );
  }
}
