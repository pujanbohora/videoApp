// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class LanguageText extends StatelessWidget {
  String text;
  double? fontsize;
  var maxline, fontstyle, fontwaight, textalign;
  Color color;
  var overflow;

  LanguageText(
      {Key? key,
      required this.color,
      required this.text,
      this.fontsize,
      this.maxline,
      this.overflow,
      this.textalign,
      this.fontwaight,
      this.fontstyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LocaleText(
      text,
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
