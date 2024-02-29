import 'package:flutter/material.dart';

class SearchTermSelect extends StatefulWidget {
  VoidCallback onChange;
  SearchTermSelect({required this.onChange, super.key});

  @override
  State<SearchTermSelect> createState() => _SearchTermSelectState();
}

class _SearchTermSelectState extends State<SearchTermSelect> {
  String selectedOption = '이번 달';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedOption,
      onChanged: (String? newValue) {
        setState(() {
          selectedOption = newValue!;
          widget.onChange;
        });
      },
      items: [
        '이번 달',
        '최근 3개월',
        '최근 6개월',
        '최근 1년',
        '전체',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
