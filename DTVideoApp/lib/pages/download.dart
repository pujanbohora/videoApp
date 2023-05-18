import 'package:dtvideo/utils/color.dart';
import 'package:dtvideo/widget/language.dart';
import 'package:dtvideo/widget/myimage.dart';
import 'package:dtvideo/widget/mytext.dart';
import 'package:flutter/material.dart';

class Downloadpage extends StatefulWidget {
  const Downloadpage({Key? key}) : super(key: key);

  @override
  State<Downloadpage> createState() => _DownloadpageState();
}

class _DownloadpageState extends State<Downloadpage> {
  List<String> downloadList = <String>[
    "assets/images/downloadOne.png",
    "assets/images/downloadTwo.png",
    "assets/images/downloadThree.png",
    "assets/images/downloadFour.png",
    "assets/images/downloadFive.png",
    "assets/images/dowmloadSix.png",
    "assets/images/downloadOne.png",
    "assets/images/downloadTwo.png",
    "assets/images/downloadThree.png",
    "assets/images/downloadFour.png",
    "assets/images/downloadFive.png",
    "assets/images/dowmloadSix.png",
  ];

  List<String> downloadnameList = <String>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context, false);
              },
              child: Container(
                width: 80,
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.centerLeft,
                child: MyImage(
                    width: 20, height: 20, imagePath: "assets/images/back.png"),
              ),
            ),
            Container(
              width: 120,
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              child: LanguageText(
                  color: white,
                  text: "download",
                  fontsize: 16,
                  fontwaight: FontWeight.w500,
                  textalign: TextAlign.center,
                  fontstyle: FontStyle.normal),
            ),
            Container(
              width: 80,
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.centerRight,
              child: MyImage(
                  width: 20, height: 20, imagePath: "assets/images/search.png"),
            ),
          ],
        ),
      ),
      body: Container(
         width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: primary,
        child: SingleChildScrollView(
          child: Column(
            children:[ 
              download(),
            ],
          ),
        ),
      ),
    );
  }

  Widget download(){
    return Padding(
       padding: const EdgeInsets.all(10.0),
      child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 670,
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: downloadList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 90,
                      color: primary,
                      child: Row(
                        children: [
                          Container(
                            width: 120,
                            height: MediaQuery.of(context).size.height,
                            alignment: Alignment.topCenter,
                            padding: const EdgeInsets.all(3),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                downloadList[index],
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              margin: const EdgeInsets.only(left: 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText(
                                      color: white,
                                      text: "Ray Potter",
                                      fontsize: 14,
                                      fontwaight: FontWeight.w600,
                                      textalign: TextAlign.center,
                                      fontstyle: FontStyle.normal),
                                  MyText(
                                      color: white,
                                      text: "Behind the scene from....",
                                      fontsize: 10,
                                      maxline: 1,
                                      overflow: TextOverflow.ellipsis,
                                      fontwaight: FontWeight.w600,
                                      textalign: TextAlign.center,
                                      fontstyle: FontStyle.normal),
                                  MyText(
                                      color: downloadMbcolor,
                                      text: "8.9 MB",
                                      fontsize: 10,
                                      fontwaight: FontWeight.w600,
                                      textalign: TextAlign.center,
                                      fontstyle: FontStyle.normal)
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 50,
                            height: MediaQuery.of(context).size.height,
                            alignment: Alignment.bottomCenter,
                            child: MyImage(
                                width: 15,
                                height: 15,
                                imagePath: "assets/images/downloadmenu.png"),
                          ),
                        ],
                      )),
                );
              }),
        ),
    );
  }
}
