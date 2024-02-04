import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';

class ListServiceCard extends StatelessWidget {
  const ListServiceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 120,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/sample/main_sample01.jpg'),
              fit: BoxFit.fill
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        SizedBox(height: 5,),
        Text('꽃 바구니', style: TextStyle( fontWeight: FontWeight.bold ),),
      ],
    );
  }
}
