import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget iphone;
  final Widget macbook;
  const ResponsiveLayout({ Key? key, required this.iphone,required this.macbook})
      : super(key: key);

  static int iphoneLimit = 650;

  static bool isIphone(BuildContext context) =>
      MediaQuery.of(context).size.width < iphoneLimit;


  static bool isMacbook(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1000;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth < iphoneLimit) {
        return iphone;
      }
       else {
        return macbook;
      }
    });
  }
}
