import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyNetworkImage extends StatelessWidget {

  double height;
  double width;
  String imagePath;
  // ignore: prefer_typing_uninitialized_variables
  var fit;

  MyNetworkImage(
      {Key? key,
      required this.width,
      required this.height,
      required this.imagePath,
      this.fit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imagePath,
      height: height,
      width: width,
      fit: fit,
      // alignment: alignment,
    );
  }
}