import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchKeywordItem extends StatelessWidget {
  const SearchKeywordItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Icon(Icons.search),
          Text("dsadsadasd"),
          Spacer(),
          IconButton(onPressed: (){}, icon: Icon(Icons.close))
        ],
      ),
    );
  }
}
