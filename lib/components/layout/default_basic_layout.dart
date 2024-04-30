import 'package:flutter/material.dart';

class DefaultBasicLayout extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;

  const DefaultBasicLayout({required this.child, this.backgroundColor, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
              color: Colors.white,
              child: child),
        ),
      ),
    );
  }
}
