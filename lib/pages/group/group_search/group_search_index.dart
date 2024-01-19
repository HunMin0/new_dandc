import 'package:Deal_Connect/components/layout/default_logo_layout.dart';
import 'package:flutter/material.dart';

class GroupSearchIndex extends StatefulWidget {
  const GroupSearchIndex({super.key});

  @override
  State<GroupSearchIndex> createState() => _GroupSearchIndexState();
}

class _GroupSearchIndexState extends State<GroupSearchIndex> {
  @override
  Widget build(BuildContext context) {
    return DefaultLogoLayout(
        titleName: '그룹찾기',
        child: Text("그룹찾기")
    );
  }
}
