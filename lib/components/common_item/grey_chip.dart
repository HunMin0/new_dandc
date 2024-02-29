import 'package:flutter/cupertino.dart';

class GreyChip extends StatelessWidget {
  String chipText;

  GreyChip({required this.chipText, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Color(0xFFf5f6fa),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 7.0),
          child: Text(
            chipText,
            style: TextStyle(
                color: Color(0xFF5f5f66),
                fontSize: 11.0,
                fontWeight: FontWeight.w500),
          ),
        )
    );
  }
}
