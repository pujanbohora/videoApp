import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyImage extends StatelessWidget {
  double height;
  double width;
  String imagePath;
  var color;
  // ignore: prefer_typing_uninitialized_variables
  var fit;
  // var alignment;

  MyImage(
      {Key? key,
      required this.width,
      required this.height,
      required this.imagePath,
      this.color,
      this.fit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      height: height,
      color: color,
      width: width,
      fit: fit,
      // alignment: alignment,
    );
  }
}