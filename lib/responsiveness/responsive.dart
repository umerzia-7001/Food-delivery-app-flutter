 import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget iphone;
  final Widget macbook;

  const ResponsiveLayout({
    Key? key,
    required this.iphone,
    required this.macbook,
  }) : super(key: key);

  static bool isIphone(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;


  static bool isMacbook(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1000;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1000) {
          return macbook;

        } else {
          return iphone;
        }
      },
    );
  }
}
