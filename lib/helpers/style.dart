
import 'package:flutter/material.dart';
import './colors.dart' as colors;

class PrimaryText extends StatelessWidget {
  final double? size;
  final FontWeight? fontWeight;
  final Color? color;
  final String? text;
  final double? height;

  const PrimaryText({
     required this.text,
     this.fontWeight ,
     this.color ,
     this.size ,
     this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text!,
        style: TextStyle(
          color: color,
          height: height,
          fontFamily: 'Schyler',
          fontSize: size,
          fontWeight: fontWeight,
        ),);
  }
}
