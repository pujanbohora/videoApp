import 'package:dtvideo/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

// Rectangular
  // ignore: use_key_in_widget_constructors
  const CustomWidget.rectangular(
      {this.width = double.infinity, required this.height})
      // ignore: unnecessary_this
      : this.shapeBorder = const RoundedRectangleBorder();

// Circle
  // ignore: use_key_in_widget_constructors
  const CustomWidget.circular(
      {this.width = double.infinity,
      required this.height,
      this.shapeBorder = const CircleBorder()});

// Round corner Container
  // ignore: use_key_in_widget_constructors
  const CustomWidget.roundcorner(
      {required this.width,
      required this.height,
      this.shapeBorder = const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
        Radius.circular(15),
      ))});

// for line / text
  // ignore: use_key_in_widget_constructors
  const CustomWidget.roundrectborder(
      {this.width = double.infinity,
      required this.height,
      this.shapeBorder = const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
        Radius.circular(5),
      ))});

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: followPagegradiantOne,
        highlightColor: borderFav,
        period: const Duration(seconds: 5),
        child: Container(
          padding: const EdgeInsets.all(5.0),
          margin: const EdgeInsets.all(5.0),
          width: width,
          height: height,
          decoration: ShapeDecoration(
            color: Colors.grey[400]!,
            shape: shapeBorder,
          ),
        ),
      );
}
