import 'package:flutter/cupertino.dart';

class ColorChip extends StatelessWidget {
  String chipText;
  Color color;
  Color textColor;

  ColorChip(
      {required this.chipText,
      required this.color,
      required this.textColor,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 7.0),
          child: Text(
            chipText,
            style: TextStyle(
                color: textColor,
                fontSize: 11.0,
                fontWeight: FontWeight.w500),
          ),
        ));
  }
}
