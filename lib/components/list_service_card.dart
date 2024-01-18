import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';

class ListServiceCard extends StatelessWidget {
  const ListServiceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: HexColor("#FFFFFF"),
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text("이미지")
          ],
        ),
      ),
    );
  }
}
