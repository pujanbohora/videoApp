import 'package:dtvideo/pages/detailspage.dart';
import 'package:dtvideo/provider/apiprovider.dart';
import 'package:dtvideo/utils/color.dart';
import 'package:dtvideo/utils/customwidget.dart';
import 'package:dtvideo/widget/ibarraText.dart';
import 'package:dtvideo/widget/language.dart';
import 'package:dtvideo/widget/myimage.dart';
import 'package:dtvideo/widget/mynetworkimg.dart';
import 'package:dtvideo/widget/mytext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Foryou extends StatefulWidget {
  const Foryou({Key? key}) : super(key: key);

  @override
  State<Foryou> createState() => ForyouState();
}

class ForyouState extends State<Foryou> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: primary,
        title: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context, false);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: MyImage(
                      width: 20,
                      height: 20,
                      imagePath: "assets/images/back.png",
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 10,
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: LanguageText(
                      color: white,
                      fontsize: 14,
                      fontwaight: FontWeight.w600,
                      maxline: 1,
                      text: "foryou",
                      textalign: TextAlign.center,
                      fontstyle: FontStyle.normal),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            foryouSeeAll(),
          ],
        ),
      ),
    );
  }

  Widget foryouSeeAll() {
    return Consumer<ApiProvider>(
        builder: (context, featurevideoprovider, child) {
      if (!featurevideoprovider.loading) {
        return foryoushimmer();
      } else {
        if (featurevideoprovider.videomodel.status == 200 &&
            (featurevideoprovider.videomodel.result?.length ?? 0) > 0) {
          return Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: primary,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2.5,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8),
              itemCount: featurevideoprovider.videomodel.result?.length ?? 0,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return DetailsPage(
                            videoid: featurevideoprovider
                                    .videomodel.result?[index].id
                                    .toString() ??
                                "",
                            catid: featurevideoprovider
                                    .videomodel.result?[index].categoryId
                                    .toString() ??
                                "",
                          );
                        },
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        color: primary,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Stack(children: [
                          Align(
                            alignment: AlignmentDirectional.center,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                foregroundDecoration: BoxDecoration(
                                  color: white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  gradient: LinearGradient(
                                    colors: [
                                      foryougradiantOne.withOpacity(0.2),
                                      foryougradiantTwo.withOpacity(0.8),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    stops: const [0.5, 2],
                                  ),
                                ),
                                child: MyNetworkImage(
                                  imagePath: featurevideoprovider
                                          .videomodel.result?[index].image
                                          .toString() ??
                                      "",
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: Align(
                                alignment: Alignment.center,
                                child: MyImage(
                                    width: 40,
                                    height: 40,
                                    imagePath: "assets/images/videoplay.png")),
                          ),
                          // SizedBox(
                          //   width: MediaQuery.of(context).size.width,
                          //   height: MediaQuery.of(context).size.height,
                          //   child: Align(
                          //     alignment: Alignment.topRight,
                          //     child: Padding(
                          //       padding:
                          //           const EdgeInsets.only(top: 7, right: 7),
                          //       child: Row(
                          //         mainAxisAlignment: MainAxisAlignment.end,
                          //         children: [
                          //           Consumer<ApiProvider>(builder:
                          //               (context, addfavouriteprovider, child) {
                          //             return MyImage(
                          //                 width: 20,
                          //                 height: 20,
                          //                 imagePath: "assets/images/like.png");
                          //           }),
                          //           const SizedBox(
                          //             width: 10,
                          //           ),
                          //           MyImage(
                          //               width: 20,
                          //               height: 20,
                          //               imagePath: "assets/images/share.png"),
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 7, left: 7),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText(
                                        color: white,
                                        fontsize: 10,
                                        fontwaight: FontWeight.w600,
                                        text: featurevideoprovider
                                                .videomodel.result?[index].name
                                                .toString() ??
                                            "",
                                        textalign: TextAlign.center,
                                        fontstyle: FontStyle.normal),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    IbarraText(
                                      text: featurevideoprovider
                                          .videomodel.result![index].artistName
                                          .toString(),
                                      maxline: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textalign: TextAlign.center,
                                      color: foryouYellow,
                                      fontsize: 10,
                                      fontstyle: FontStyle.normal,
                                      fontwaight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return Container();
        }
      }
    });
  }

  Widget foryoushimmer() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: primary,
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: List.generate(10, (index) {
          return Column(children: const [
            CustomWidget.roundcorner(
              height: 140,
              width: 160,
            )
          ]);
        }),
      ),
    );
  }
}
