import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';

class ListServiceCard extends StatelessWidget {
  const ListServiceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HexColor("#F6FDFA"),
      child: Container(
        margin: EdgeInsets.all(10.0),
        width: 180.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/sample/service_sample01.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
