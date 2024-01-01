import 'package:flutter/material.dart';

class TabInfo {
  final String label;

  const TabInfo({
    required this.label,
  });
}

const TABS = [
  TabInfo(label: '사업장'),
  TabInfo(label: '작성한 글'),
];
