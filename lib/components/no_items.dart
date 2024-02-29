import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';

class NoItems extends StatelessWidget {
  const NoItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFF5F6FA),
        borderRadius: BorderRadius.all(Radius.circular(10.0))
      ),
      child: Text("등록된 내용이 없습니다.", style: TextStyle(color: HexColor('#aaaaaf')),textAlign: TextAlign.center,)
    );
  }
}
