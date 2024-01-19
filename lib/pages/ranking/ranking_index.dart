import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:flutter/cupertino.dart';

class RankingIndex extends StatefulWidget {
  const RankingIndex({super.key});

  @override
  State<RankingIndex> createState() => _RankingIndexState();
}

class _RankingIndexState extends State<RankingIndex> {
  @override
  Widget build(BuildContext context) {
    return DefaultLogoLayout(
        titleName: "Deal&Connect 랭킹",
        child: Text("test")
    );
  }
}
