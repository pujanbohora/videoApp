import 'package:dtvideo/utils/color.dart';
import 'package:dtvideo/widget/language.dart';
import 'package:dtvideo/widget/myimage.dart';
import 'package:dtvideo/widget/mytext.dart';
import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  const NoData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: primary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyImage(
              width: MediaQuery.of(context).size.width,
              height: 200,
              imagePath: "assets/images/ic_nodata.png"),
          const SizedBox(
            height: 20,
          ),
          LanguageText(
              color: white,
              text: "nodata",
              textalign: TextAlign.center,
              fontsize: 16,
              maxline: 1,
              overflow: TextOverflow.ellipsis,
              fontwaight: FontWeight.w600,
              fontstyle: FontStyle.normal),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(60, 0, 60, 0),
            child: LanguageText(
                color: nodatachildText,
                text: "nodatatext",
                textalign: TextAlign.center,
                fontsize: 14,
                overflow: TextOverflow.ellipsis,
                maxline: 2,
                fontwaight: FontWeight.w400,
                fontstyle: FontStyle.normal),
          ),
        ],
      ),
    );
  }
}
