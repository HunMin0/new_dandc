import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:flutter/cupertino.dart';

class RecieptView extends StatelessWidget {
  const RecieptView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLogoLayout(
        titleName: '영수증 보기',
        child: Expanded(
          child: Text("영수증 이미지"),
        )
    );
  }
}
