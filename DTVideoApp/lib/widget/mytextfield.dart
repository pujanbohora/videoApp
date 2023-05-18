// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:dtvideo/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class MyTextField extends StatelessWidget {
  late String hinttext;
  double size;
  late Color color;
  var textInputAction, controller, keyboardType, onChanged;
  bool obscureText;

  MyTextField(
      {Key? key,
      required this.hinttext,
      required this.keyboardType,
      this.controller,
      this.onChanged,
      required this.size,
      required this.color,
      required this.textInputAction,
      required this.obscureText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: textInputAction,
      obscureText: obscureText,
      controller: controller,
      keyboardType: keyboardType,
      maxLines: 1,
      onChanged: onChanged,
      style: GoogleFonts.inter(
        color: white,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        hintStyle: GoogleFonts.inter(
            color: color, fontSize: size, fontWeight: FontWeight.w500),
      ),
    );
  }
}
