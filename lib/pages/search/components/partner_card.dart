import 'package:Deal_Connect/components/const/setting_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';

class PartnerCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String markets;

  const PartnerCard({
    required this.imagePath,
    required this.name,
    required this.markets,
    super.key
  });


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10.0),
          width: 110,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: HexColor("#F5F6FA")
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: HexColor("#F5F6FA"),
                  image: DecorationImage(
                    image: AssetImage('assets/images/sample/main_sample01.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 8,),
              Text(name, style: SettingStyle.SUB_TITLE_STYLE, overflow: TextOverflow.ellipsis,),
              const SizedBox(height: 1,),
              Text(markets, style: SettingStyle.SUB_GREY_TEXT, overflow: TextOverflow.ellipsis),
              const Spacer(),
            ],
          ),
        ),
        SizedBox(width: 15)
      ],
    );
  }
}
