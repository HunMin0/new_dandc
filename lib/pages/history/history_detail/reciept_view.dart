import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:flutter/cupertino.dart';

class ReceiptView extends StatelessWidget {
  ImageProvider receiptImage;

  ReceiptView({required this.receiptImage, super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLogoLayout(
        titleName: '영수증 보기',
        child: Column(
          children: [
            Expanded(
              child: Image(image: receiptImage),
            ),
          ],
        )
    );
  }
}
