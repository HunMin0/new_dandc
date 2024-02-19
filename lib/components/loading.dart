import 'package:Deal_Connect/components/layout/default_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Center(
        child: Container(
          color: HexColor("#ffffff"),
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
