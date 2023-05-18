// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class MyText extends StatelessWidget {
  String? text;
  double? fontsize;
  var maxline, fontstyle, fontwaight, textalign;
  Color? color;
  var overflow;

  MyText(
      {Key? key,
      this.color,
      this.text,
      this.fontsize,
      this.maxline,
      this.overflow,
      this.textalign,
      this.fontwaight,
      this.fontstyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toString(),
      textAlign: textalign,
      overflow: overflow,
      maxLines: maxline,
      style: GoogleFonts.inter(
          fontSize: fontsize,
          fontStyle: fontstyle,
          color: color,
          fontWeight: fontwaight),
    );
  }
}
