import 'dart:developer';

import 'package:dtvideo/pages/follow.dart';
import 'package:dtvideo/pages/login.dart';
import 'package:dtvideo/pages/nodata.dart';
import 'package:dtvideo/provider/apiprovider.dart';
import 'package:dtvideo/utils/color.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:dtvideo/utils/customwidget.dart';
import 'package:dtvideo/widget/language.dart';
import 'package:dtvideo/widget/myimage.dart';
import 'package:dtvideo/widget/mynetworkimg.dart';
import 'package:dtvideo/widget/mytext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:provider/provider.dart';
import '../utils/sharedpre.dart';

class Profile extends StatefulWidget {
  var artistid;
  Profile({Key? key, required this.artistid}) : super(key: key);
  @override
  State<Profile> createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  SharedPre sharePref = SharedPre();
  String? userid;
  int? tmp = 0;
  int? count = 4;
  static const tiles = [
    GridTile(2, 4),
    GridTile(2, 2),
    GridTile(2, 2),
  ];

  @override
  void initState() {
    super.initState();
    getUserId();
    // ignore: use_build_context_synchronously
    final artistprofile = Provider.of<ApiProvider>(context, listen: false);
    artistprofile.artistprofile(widget.artistid, userid);
    artistprofile.videobyArtist(widget.artistid);
  }

  getUserId() async {
    userid = await sharePref.read("userid") ?? "";
    log('userId===> $userid');
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    return Scaffold(
      backgroundColor: primary,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Consumer<ApiProvider>(
            builder: (context, artistprofileprovider, child) {
          if (!artistprofileprovider.loading) {
            return profileshimmer();
          } else {
            if (artistprofileprovider.artistprofilemodel.status == 200) {
              log('===>follow ${artistprofileprovider.artistprofilemodel.result?.isfollow}');
              return Container(
                width: MediaQuery.of(context).size.width,
                color: primary,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        // Background image
                        Container(
                          width: MediaQuery.of(context).size.width,
                          foregroundDecoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(24)),
                            gradient: LinearGradient(
                              colors: [
                                editgradiantOne.withOpacity(0.2),
                                editgradiantTwo.withOpacity(0.6),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: const [0.5, 2],
                            ),
                          ),
                          child: MyImage(
                              width: MediaQuery.of(context).size.width,
                              height: 300,
                              fit: BoxFit.cover,
                              imagePath: "assets/images/editprofile.png"),
                        ),
                        // Round user image with text
                        Positioned.fill(
                          bottom: 5,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      border: const GradientBoxBorder(
                                        width: 4,
                                        gradient: LinearGradient(
                                          colors: [
                                            categorygradiantBorderOne,
                                            categorygradiantBorderTwo
                                          ],
                                        ),
                                      ),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: MyNetworkImage(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        imagePath: artistprofileprovider
                                                    .artistprofilemodel
                                                    .status ==
                                                200
                                            ? artistprofileprovider
                                                    .artistprofilemodel
                                                    .result
                                                    ?.image
                                                    .toString() ??
                                                "https://i.pinimg.com/564x/5d/69/42/5d6942c6dff12bd3f960eb30c5fdd0f9.jpg"
                                            : "https://i.pinimg.com/564x/5d/69/42/5d6942c6dff12bd3f960eb30c5fdd0f9.jpg",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                MyText(
                                    color: white,
                                    text: artistprofileprovider
                                            .artistprofilemodel.result?.name
                                            .toString() ??
                                        "Guest User",
                                    fontsize: 16,
                                    fontwaight: FontWeight.w600,
                                    textalign: TextAlign.center,
                                    fontstyle: FontStyle.normal),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: MyText(
                                      color: white,
                                      text: artistprofileprovider
                                              .artistprofilemodel.result?.bio
                                              .toString() ??
                                          "",
                                      fontsize: 14,
                                      maxline: 2,
                                      overflow: TextOverflow.ellipsis,
                                      fontwaight: FontWeight.w500,
                                      textalign: TextAlign.center,
                                      fontstyle: FontStyle.normal),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (userid!.isEmpty || userid == "") {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return const Login();
                                          },
                                        ),
                                      );
                                    } else {
                                      if (artistprofileprovider
                                              .artistprofilemodel
                                              .result
                                              ?.isfollow ==
                                          1) {
                                        artistprofileprovider.artistprofilemodel
                                            .result?.isfollow = 0;
                                      } else {
                                        artistprofileprovider.artistprofilemodel
                                            .result?.isfollow = 1;
                                      }

                                      log('===>follow ${artistprofileprovider.artistprofilemodel.result?.isfollow}');
                                      artistprofileprovider.addfollow(
                                          userid,
                                          artistprofileprovider
                                              .artistprofilemodel.result?.id);

                                      if (!artistprofileprovider.loading) {
                                        const CircularProgressIndicator();
                                      } else {
                                        artistprofileprovider.artistprofilemodel
                                            .result?.isfollow = 1;
                                      }
                                    }
                                  },
                                  child: Container(
                                    width: 100,
                                    height: 30,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: artistfolowBtn,
                                      border: Border.all(
                                        color: white,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8)),
                                    ),
                                    child: LanguageText(
                                        color: white,
                                        text: (userid!.isEmpty || userid == "")
                                            ? "follow"
                                            : (artistprofileprovider
                                                        .artistprofilemodel
                                                        .result
                                                        ?.isfollow ==
                                                    1
                                                ? "follow"
                                                : "unfollow"),
                                        fontsize: 14,
                                        fontwaight: FontWeight.w500,
                                        textalign: TextAlign.center,
                                        fontstyle: FontStyle.normal),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 30,
                          left: 20,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context, false);
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  alignment: Alignment.centerLeft,
                                  child: MyImage(
                                      width: 30,
                                      height: 30,
                                      imagePath:
                                          "assets/images/detailback.png"),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Total counts Row
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                MyText(
                                    color: white,
                                    text: artistprofileprovider
                                            .artistprofilemodel
                                            .result
                                            ?.totalVideo
                                            .toString() ??
                                        "",
                                    fontsize: 12,
                                    fontwaight: FontWeight.w500,
                                    textalign: TextAlign.left,
                                    fontstyle: FontStyle.normal),
                                const SizedBox(
                                  height: 4,
                                ),
                                LanguageText(
                                    color: white,
                                    text: "video",
                                    fontsize: 12,
                                    fontwaight: FontWeight.w500,
                                    textalign: TextAlign.center,
                                    fontstyle: FontStyle.normal)
                              ],
                            ),
                            const VerticalDivider(
                              thickness: 1,
                              width: 10,
                              color: white,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const Follow();
                                    },
                                  ),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MyText(
                                      color: white,
                                      text: artistprofileprovider
                                              .artistprofilemodel
                                              .result
                                              ?.totalLike
                                              .toString() ??
                                          "",
                                      fontsize: 12,
                                      fontwaight: FontWeight.w500,
                                      textalign: TextAlign.center,
                                      fontstyle: FontStyle.normal),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  LanguageText(
                                      color: white,
                                      text: "followers",
                                      fontsize: 12,
                                      fontwaight: FontWeight.w500,
                                      textalign: TextAlign.center,
                                      fontstyle: FontStyle.normal),
                                ],
                              ),
                            ),
                            const VerticalDivider(
                              thickness: 1,
                              width: 10,
                              color: white,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MyText(
                                    color: white,
                                    text: artistprofileprovider
                                            .artistprofilemodel
                                            .result
                                            ?.totalView
                                            .toString() ??
                                        "",
                                    fontsize: 12,
                                    fontwaight: FontWeight.w500,
                                    textalign: TextAlign.center,
                                    fontstyle: FontStyle.normal),
                                const SizedBox(
                                  height: 4,
                                ),
                                LanguageText(
                                    color: white,
                                    text: "views",
                                    fontsize: 12,
                                    fontwaight: FontWeight.w500,
                                    textalign: TextAlign.center,
                                    fontstyle: FontStyle.normal),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Consumer<ApiProvider>(
                        builder: (context, videobyartistProvider, child) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 40,
                              margin: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                              alignment: Alignment.centerLeft,
                              child: LanguageText(
                                  color: white,
                                  text: "mylist",
                                  fontsize: 14,
                                  fontwaight: FontWeight.w500,
                                  textalign: TextAlign.center,
                                  fontstyle: FontStyle.normal),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.fromLTRB(10, 2, 10, 0),
                              child: MediaQuery.removePadding(
                                context: context,
                                removeTop: true,
                                child: Flexible(
                                  child: StaggeredGrid.count(
                                    crossAxisCount: 4,
                                    mainAxisSpacing: 5,
                                    crossAxisSpacing: 5,
                                    children: [
                                      ...videobyartistProvider
                                          .videobyartistmodel.result!
                                          .mapIndexed((index, tile) {
                                        if (tmp == index) {
                                          count = 4;
                                          tmp = tmp! + 4;
                                        } else {
                                          count = 2;
                                        }
                                        return StaggeredGridTile.count(
                                          crossAxisCellCount: 2,
                                          mainAxisCellCount:
                                              num.parse(count.toString()),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: MyNetworkImage(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 10,
                                              imagePath: videobyartistProvider
                                                      .videobyartistmodel
                                                      .result?[index]
                                                      .image ??
                                                  "",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              );
            } else {
              return const NoData();
            }
          }
        }),
      ),
    );
  }

  Widget profileshimmer() {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: primary,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // UserImage and Name
              Flexible(
                flex: 1,
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      foregroundDecoration: BoxDecoration(
                        color: white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(24)),
                        gradient: LinearGradient(
                          colors: [
                            editgradiantOne.withOpacity(0.2),
                            editgradiantTwo.withOpacity(0.6),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0.5, 2],
                        ),
                      ),
                      child: CustomWidget.rectangular(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      alignment: Alignment.bottomCenter,
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(3),
                              child: CustomWidget.circular(
                                height: 100,
                                width: 100,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            // const CustomWidget.roundrectborder(
                            //   height: 10,
                            //   width: 150,
                            // ),
                            const SizedBox(
                              height: 10,
                            ),
                            // const CustomWidget.roundrectborder(
                            //   height: 10,
                            //   width: 100,
                            // ),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                // ignore: use_build_context_synchronously
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const Follow();
                                    },
                                  ),
                                );
                              },
                              child: const CustomWidget.rectangular(
                                height: 20,
                                width: 100,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // follower Video and views
              Flexible(
                flex: 2,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    CustomWidget.roundrectborder(
                                      height: 5,
                                      width: 50,
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    CustomWidget.roundrectborder(
                                      height: 5,
                                      width: 70,
                                    ),
                                  ],
                                ),
                              ),
                              CustomWidget.rectangular(
                                height: MediaQuery.of(context).size.height,
                                width: 1,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    CustomWidget.roundrectborder(
                                      height: 5,
                                      width: 50,
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    CustomWidget.roundrectborder(
                                      height: 5,
                                      width: 70,
                                    ),
                                  ],
                                ),
                              ),
                              CustomWidget.rectangular(
                                height: MediaQuery.of(context).size.height,
                                width: 1,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    CustomWidget.roundrectborder(
                                      height: 5,
                                      width: 50,
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    CustomWidget.roundrectborder(
                                      height: 5,
                                      width: 70,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 9,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.fromLTRB(5, 5, 5, 20),
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                margin: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                                alignment: Alignment.centerLeft,
                                child: const CustomWidget.roundrectborder(
                                  height: 10,
                                  width: 100,
                                ),
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        alignment: Alignment.topCenter,
                                        margin: const EdgeInsets.fromLTRB(
                                            20, 2, 20, 0),
                                        child: MediaQuery.removePadding(
                                          context: context,
                                          removeTop: true,
                                          child: Flexible(
                                            child: StaggeredGrid.count(
                                              crossAxisCount: 4,
                                              mainAxisSpacing: 5,
                                              crossAxisSpacing: 5,
                                              children: [
                                                ...tiles
                                                    .mapIndexed((index, tile) {
                                                  return StaggeredGridTile
                                                      .count(
                                                    crossAxisCellCount:
                                                        tile.crossAxisCount,
                                                    mainAxisCellCount:
                                                        index % 2 == 0 ? 2 : 4,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: InkWell(
                                                        onTap: () {
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  "Click index:$index",
                                                              toastLength: Toast
                                                                  .LENGTH_SHORT,
                                                              gravity:
                                                                  ToastGravity
                                                                      .BOTTOM,
                                                              timeInSecForIosWeb:
                                                                  2,
                                                              backgroundColor:
                                                                  primarycolor,
                                                              textColor: white,
                                                              fontSize: 14);
                                                        },
                                                        child: CustomWidget
                                                            .roundcorner(
                                                          height: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .height,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class GridTile {
  const GridTile(this.crossAxisCount, this.mainAxisCount);
  final int crossAxisCount;
  final int mainAxisCount;
}
