import 'package:dtvideo/pages/nodata.dart';
import 'package:dtvideo/provider/apiprovider.dart';
import 'package:dtvideo/utils/color.dart';
import 'package:dtvideo/utils/customwidget.dart';
import 'package:dtvideo/widget/language.dart';
import 'package:dtvideo/widget/myimage.dart';
import 'package:dtvideo/widget/mynetworkimg.dart';
import 'package:dtvideo/widget/mytext.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:provider/provider.dart';

import 'detailspage.dart';

class Videos extends StatefulWidget {
  String? id, type, name;
  Videos({Key? key, this.id, this.type, this.name}) : super(key: key);

  @override
  State<Videos> createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  @override
  void initState() {
    final videolistprovider = Provider.of<ApiProvider>(context, listen: false);
    videolistprovider.videoslist(widget.id, widget.type);
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
                    debugPrint("Click");
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MyText(
                          color: white,
                          fontsize: 16,
                          fontwaight: FontWeight.w600,
                          maxline: 1,
                          text: '${widget.name}',
                          textalign: TextAlign.center,
                          fontstyle: FontStyle.normal),
                      const SizedBox(width: 3),
                      LanguageText(
                          color: white,
                          fontsize: 16,
                          fontwaight: FontWeight.w600,
                          maxline: 1,
                          text: "video",
                          textalign: TextAlign.center,
                          fontstyle: FontStyle.normal),
                    ],
                  ),
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
            getVideos(),
          ],
        ),
      ),
    );
  }

  Widget getVideos() {
    return Consumer<ApiProvider>(builder: (context, videosprovider, child) {
      if (!videosprovider.loading) {
        return trandingVideoshimmer();
      } else {
        if (videosprovider.videosmodel.status == 200 &&
            (videosprovider.videosmodel.result?.length ?? 0) > 0) {
          return Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: primary,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2.2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemCount: videosprovider.videosmodel.result?.length ?? 0,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailsPage(
                                videoid: videosprovider
                                        .videosmodel.result?[index].id ??
                                    "",
                                catid: videosprovider.videosmodel.result?[index]
                                        .categoryId ??
                                    "",
                              )),
                    );
                  },
                  child: SizedBox(
                    child: Stack(
                      children: [
                        Align(
                          alignment: AlignmentDirectional.center,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              decoration: BoxDecoration(
                                border: const GradientBoxBorder(
                                  width: 4,
                                  gradient: LinearGradient(
                                    colors: [
                                      borderFav,
                                      favouritegradiantBorderTwo,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    stops: const [0, 2],
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              // foregroundDecoration: BoxDecoration(
                              //   gradient: LinearGradient(
                              //     colors: [
                              //       foryougradiantOne.withOpacity(0.1),
                              //       foryougradiantTwo.withOpacity(0.8),
                              //     ],
                              //     begin: Alignment.topCenter,
                              //     end: Alignment.bottomCenter,
                              //     stops: const [0.4, 3],
                              //   ),
                              // ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: MyNetworkImage(
                                  imagePath: videosprovider
                                          .videosmodel.result?[index].image
                                          .toString() ??
                                      "https://i.pinimg.com/564x/5d/69/42/5d6942c6dff12bd3f960eb30c5fdd0f9.jpg",
                                  fit: BoxFit.fill,
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: MyImage(
                              width: 40,
                              height: 40,
                              imagePath: "assets/images/play.png"),
                        ),
                        Positioned(
                          bottom: 10,
                          child: Center(
                            child: Container(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: MyText(
                                  color: white,
                                  text: videosprovider
                                          .videosmodel.result?[index].name
                                          .toString() ??
                                      "",
                                  fontsize: 12,
                                  fontwaight: FontWeight.w500,
                                  maxline: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textalign: TextAlign.center,
                                  fontstyle: FontStyle.normal),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return const NoData();
        }
      }
    });
  }

  Widget trandingVideoshimmer() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: primary,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2.2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5),
        itemBuilder: (context, index) {
          return const CustomWidget.roundcorner(
            width: 200,
            height: 70,
          );
        },
      ),
    );
  }
}
