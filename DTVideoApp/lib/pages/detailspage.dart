// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:dtvideo/model/videobyidmodel.dart' as videomodel;
import 'package:dtvideo/pages/addcommentpopup.dart';
import 'package:dtvideo/pages/login.dart';
import 'package:dtvideo/pages/nodata.dart';
import 'package:dtvideo/pages/player_pod.dart';
import 'package:dtvideo/provider/apiprovider.dart';
import 'package:dtvideo/provider/commanprovider.dart';
import 'package:dtvideo/subscription/subscription.dart';
import 'package:dtvideo/utils/adhelper.dart';
import 'package:dtvideo/utils/color.dart';
import 'package:dtvideo/utils/customwidget.dart';
import 'package:dtvideo/utils/sharedpre.dart';
import 'package:dtvideo/widget/language.dart';
import 'package:dtvideo/widget/myimage.dart';
import 'package:dtvideo/widget/mynetworkimg.dart';
import 'package:dtvideo/widget/mytext.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import '../utils/utils.dart';
import 'videos.dart';

// ignore: must_be_immutable
class DetailsPage extends StatefulWidget {
  var videoid, catid;
  DetailsPage({Key? key, required this.videoid, this.catid}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final ScrollController _scrollcontroller = ScrollController();

  SharedPre sharePref = SharedPre();
  var userid = "";
  var isBuy = "";
  List<videomodel.Result>? videolist;
  bool viewall = false;
  final formatter = intl.NumberFormat.compact(locale: "en_IN");

  @override
  void initState() {
    debugPrint("videoId:${widget.videoid}");
    getUserid();
    getIsBuy();
    // ignore: use_build_context_synchronously
    final relateditem = Provider.of<ApiProvider>(context, listen: false);
    debugPrint("VideoId DetailPage${widget.videoid}");
    relateditem.videobyid(widget.videoid);
    relateditem.viewcomment(widget.videoid);
    relateditem.relatedvideo(widget.catid, widget.videoid);
    relateditem.addview(widget.videoid);
    super.initState();
  }

  getIsBuy() async {
    isBuy = await sharePref.read("is_buy") ?? "0";
    log("isBuy===> $isBuy");
  }

  getUserid() async {
    userid = await sharePref.read("userid") ?? "";
    log("UserId===> $userid");
  }

  @override
  Widget build(BuildContext context) {
    log("==> detail loading Build called");

    return Scaffold(
      backgroundColor: primary,
      // VideoById Provider
      body: SingleChildScrollView(
        child: Consumer<ApiProvider>(
          builder: (context, videobyidprovider, child) {
            log('==> detail loading ${!videobyidprovider.loading}');
            getIsBuy();
            if (!videobyidprovider.loading) {
              return detailshimmer();
            } else {
              if (videobyidprovider.videobyidmodel.status == 200 &&
                  (videobyidprovider.videobyidmodel.result?.length ?? 0) > 0) {
                Provider.of<CommanProvider>(context).init(
                    videobyidprovider.videobyidmodel.result?[0].isBookmark ??
                        0);
                log('===>follow ${videobyidprovider.videobyidmodel.result?[0].isFollow}');
                return Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 420,
                          foregroundDecoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                detailpagegradiantOne.withOpacity(0.2),
                                detailpagegradiantTwo.withOpacity(1),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: const [0.5, 2],
                            ),
                          ),
                          child: MyNetworkImage(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              fit: BoxFit.fill,
                              imagePath: videobyidprovider
                                      .videobyidmodel.result?[0].image ??
                                  "https://i.pinimg.com/564x/5d/69/42/5d6942c6dff12bd3f960eb30c5fdd0f9.jpg"),
                        ),
                        Positioned.fill(
                          bottom: 10,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // playicon
                                SizedBox(
                                  child: InkWell(
                                    onTap: () {
                                      log("typeVideo ====> ${videobyidprovider.videobyidmodel.result?[0].videoType}");
                                      if (userid.isEmpty || userid == "") {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return const Login();
                                            },
                                          ),
                                        );
                                      } else {
                                        if (videobyidprovider.videobyidmodel
                                                    .result?[0].isPaid ==
                                                "1" &&
                                            isBuy == "0") {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Subscription()));
                                        } else {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return PlayerPod(
                                                  videobyidprovider
                                                          .videobyidmodel
                                                          .result?[0]
                                                          .url?[0]
                                                          .toString() ??
                                                      "",
                                                  videobyidprovider
                                                          .videobyidmodel
                                                          .result?[0]
                                                          .url
                                                          .toString() ??
                                                      "",
                                                );
                                              },
                                            ),
                                          );
                                        }
                                      }
                                    },
                                    child: MyImage(
                                        width: 130,
                                        height: 130,
                                        fit: BoxFit.fill,
                                        imagePath:
                                            "assets/images/detailplay.png"),
                                  ),
                                ),
                                // TItle
                                SizedBox(
                                  child: Text(
                                    videobyidprovider
                                            .videobyidmodel.result?[0].name ??
                                        "",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.ibarraRealNova(
                                      color: white,
                                      fontSize: 22,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                MyText(
                                    color: white,
                                    text:
                                        "${videobyidprovider.videobyidmodel.result?[0].categoryName ?? ""} - ${Utils().dateConvert(videobyidprovider.videobyidmodel.result?[0].createdAt.toString() ?? "", "yyyy")}",
                                    textalign: TextAlign.center,
                                    fontsize: 12,
                                    maxline: 1,
                                    overflow: TextOverflow.ellipsis,
                                    fontwaight: FontWeight.w500,
                                    fontstyle: FontStyle.normal),
                                const SizedBox(height: 20),
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: MyNetworkImage(
                                            width: 50,
                                            height: 50,
                                            imagePath: videobyidprovider
                                                    .videobyidmodel
                                                    .result?[0]
                                                    .artistImage ??
                                                ""),
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          MyText(
                                              color: white,
                                              text: videobyidprovider
                                                      .videobyidmodel
                                                      .result?[0]
                                                      .artistName ??
                                                  "",
                                              fontsize: 16,
                                              fontwaight: FontWeight.w600,
                                              maxline: 1,
                                              overflow: TextOverflow.ellipsis,
                                              textalign: TextAlign.left,
                                              fontstyle: FontStyle.normal),
                                          const SizedBox(height: 10),
                                          InkWell(
                                            onTap: () async {
                                              if (userid.isNotEmpty ||
                                                  userid != "") {
                                                if (videobyidprovider
                                                        .videobyidmodel
                                                        .result?[0]
                                                        .isFollow ==
                                                    1) {
                                                  videobyidprovider
                                                      .videobyidmodel
                                                      .result?[0]
                                                      .isFollow = 0;
                                                } else {
                                                  videobyidprovider
                                                      .videobyidmodel
                                                      .result?[0]
                                                      .isFollow = 1;
                                                }

                                                var provider =
                                                    Provider.of<ApiProvider>(
                                                        context,
                                                        listen: false);
                                                await provider.addfollow(
                                                    userid,
                                                    videobyidprovider
                                                        .videobyidmodel
                                                        .result?[0]
                                                        .artistId);

                                                if (!provider.loading) {
                                                  Utils().showToast(provider
                                                      .successModel.message
                                                      .toString());
                                                  videobyidprovider
                                                      .videobyidmodel
                                                      .result?[0]
                                                      .isFollow = 1;
                                                }
                                              } else {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Login()),
                                                );
                                              }
                                            },
                                            child: Container(
                                              width: 100,
                                              height: 25,
                                              alignment: Alignment.center,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(6)),
                                                gradient: LinearGradient(
                                                    colors: [
                                                      followdetailgradiantOne,
                                                      followdetailgradiantTwo
                                                    ]),
                                              ),
                                              child: MyText(
                                                  color: white,
                                                  text: (userid.isNotEmpty ||
                                                          userid != "")
                                                      ? (videobyidprovider
                                                                  .videobyidmodel
                                                                  .result?[0]
                                                                  .isFollow ==
                                                              0
                                                          ? "follow"
                                                          : "unfollow")
                                                      : "follow",
                                                  fontsize: 14,
                                                  fontwaight: FontWeight.w600,
                                                  maxline: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textalign: TextAlign.left,
                                                  fontstyle: FontStyle.normal),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 30,
                          left: 20,
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
                                    imagePath: "assets/images/detailback.png"),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      // color: white,
                      margin: const EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        children: [
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              LanguageText(
                                  color: white,
                                  text: "about",
                                  fontsize: 16,
                                  fontwaight: FontWeight.w500,
                                  maxline: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textalign: TextAlign.center,
                                  fontstyle: FontStyle.normal),
                              const Spacer(),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.topLeft,
                            child: ReadMoreText(
                              videobyidprovider
                                      .videobyidmodel.result?[0].description ??
                                  "",
                              trimLines: 6,
                              preDataTextStyle:
                                  const TextStyle(fontWeight: FontWeight.w500),
                              style:
                                  const TextStyle(color: white, fontSize: 12),
                              colorClickableText: loadmore,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: '  Load More',
                              trimExpandedText: ' Load less',
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 80,
                            child: Row(
                              children: [
                                Container(
                                  width: 65,
                                  height: 65,
                                  decoration: const BoxDecoration(
                                    color: detailprimarylight,
                                    border: GradientBoxBorder(
                                        width: 3,
                                        gradient: LinearGradient(colors: [
                                          detailcirclegradiantOne,
                                          detailcirclegradiantTwo,
                                        ])),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                    gradient: LinearGradient(colors: [
                                      detailprimarylight,
                                      detailprimarylight
                                    ]),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      MyImage(
                                          width: 13,
                                          height: 13,
                                          imagePath: "assets/images/eye.png"),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      MyText(
                                          color: white,
                                          text: formatter.format(int.parse(
                                              videobyidprovider.videobyidmodel
                                                      .result?[0].vView ??
                                                  "")),
                                          fontsize: 10,
                                          fontwaight: FontWeight.w500,
                                          maxline: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textalign: TextAlign.center,
                                          fontstyle: FontStyle.normal)
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  width: 65,
                                  height: 65,
                                  decoration: const BoxDecoration(
                                    color: detailprimarylight,
                                    border: GradientBoxBorder(
                                        width: 3,
                                        gradient: LinearGradient(colors: [
                                          detailcirclegradiantOne,
                                          detailcirclegradiantTwo,
                                        ])),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                    gradient: LinearGradient(colors: [
                                      detailprimarylight,
                                      detailprimarylight
                                    ]),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      MyImage(
                                          width: 13,
                                          height: 13,
                                          imagePath:
                                              "assets/images/detailstar.png"),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      MyText(
                                          color: white,
                                          text: videobyidprovider.videobyidmodel
                                                  .result?[0].avgRating ??
                                              "",
                                          fontsize: 10,
                                          fontwaight: FontWeight.w500,
                                          maxline: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textalign: TextAlign.center,
                                          fontstyle: FontStyle.normal)
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  width: 65,
                                  height: 65,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    color: detailprimarylight,
                                    border: GradientBoxBorder(
                                        width: 3,
                                        gradient: LinearGradient(colors: [
                                          detailcirclegradiantOne,
                                          detailcirclegradiantTwo,
                                        ])),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                    gradient: LinearGradient(colors: [
                                      detailprimarylight,
                                      detailprimarylight
                                    ]),
                                  ),
                                  child: MyImage(
                                      width: 20,
                                      height: 20,
                                      imagePath:
                                          "assets/images/sharedetail.png"),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                InkWell(
                                  onTap: () async {
                                    if ((videobyidprovider.videobyidmodel
                                                .result?[0].isBookmark ??
                                            0) ==
                                        0) {
                                      videobyidprovider.videobyidmodel
                                          .result?[0].isBookmark = 1;
                                      await Provider.of<CommanProvider>(context,
                                              listen: false)
                                          .addbookmar(1);
                                      log('===>book if${videobyidprovider.videobyidmodel.result?[0].isBookmark}');
                                    } else {
                                      videobyidprovider.videobyidmodel
                                          .result?[0].isBookmark = 0;
                                      await Provider.of<CommanProvider>(context,
                                              listen: false)
                                          .addbookmar(0);
                                      log('===>book else${videobyidprovider.videobyidmodel.result?[0].isBookmark}');
                                    }
                                    await videobyidprovider.addfavourite(
                                        widget.videoid, userid);

                                    if (!videobyidprovider.loading) {
                                      const CircularProgressIndicator();
                                    } else {
                                      log("==>${videobyidprovider.addfavouritemodel.status}");
                                    }
                                  },
                                  child: Consumer<CommanProvider>(
                                    builder: (context, bookmark, child) {
                                      return Container(
                                        width: 65,
                                        height: 65,
                                        alignment: Alignment.center,
                                        decoration: const BoxDecoration(
                                          color: detailprimarylight,
                                          border: GradientBoxBorder(
                                              width: 3,
                                              gradient: LinearGradient(colors: [
                                                detailcirclegradiantOne,
                                                detailcirclegradiantTwo,
                                              ])),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50)),
                                          gradient: LinearGradient(colors: [
                                            detailprimarylight,
                                            detailprimarylight
                                          ]),
                                        ),
                                        child: bookmark.isBookmark == 0
                                            ? MyImage(
                                                width: 20,
                                                height: 20,
                                                imagePath:
                                                    "assets/images/ic_fav.png")
                                            : MyImage(
                                                width: 20,
                                                height: 20,
                                                imagePath:
                                                    "assets/images/ic_fav_tick.png"),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            color: primary,
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: [
                                          LanguageText(
                                              color: white,
                                              text: "relatedvideo",
                                              fontsize: 16,
                                              fontwaight: FontWeight.w600,
                                              textalign: TextAlign.center,
                                              fontstyle: FontStyle.normal),
                                          const Spacer(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Consumer<ApiProvider>(builder:
                                    (context, relatedvideoprovider, child) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 150,
                                    margin: const EdgeInsets.only(top: 10),
                                    alignment: Alignment.center,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: relatedvideoprovider
                                          .relatedvideomodel.result?.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return DetailsPage(
                                                    videoid: relatedvideoprovider
                                                            .relatedvideomodel
                                                            .result?[index]
                                                            .id
                                                            .toString() ??
                                                        "",
                                                    catid: relatedvideoprovider
                                                            .relatedvideomodel
                                                            .result?[index]
                                                            .categoryId
                                                            .toString() ??
                                                        "",
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 10, 0),
                                            child: Container(
                                              width: 120,
                                              //  color: danceclasess,
                                              decoration: BoxDecoration(
                                                color: danceclasess,
                                                border: Border.all(
                                                  color: danceclasess,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(11.0),
                                              ),
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(7),
                                                child: Stack(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        height: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .height,
                                                        foregroundDecoration:
                                                            BoxDecoration(
                                                          color: white,
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          8)),
                                                          gradient:
                                                              LinearGradient(
                                                            colors: [
                                                              danceclassisgradiantOne
                                                                  .withOpacity(
                                                                      0.2),
                                                              danceclassisgradiantTwo
                                                                  .withOpacity(
                                                                      0.8),
                                                            ],
                                                            begin: Alignment
                                                                .topCenter,
                                                            end: Alignment
                                                                .bottomCenter,
                                                            stops: const [
                                                              0.5,
                                                              2
                                                            ],
                                                          ),
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          child: MyNetworkImage(
                                                            imagePath: relatedvideoprovider
                                                                    .relatedvideomodel
                                                                    .result?[
                                                                        index]
                                                                    .image
                                                                    .toString() ??
                                                                "https://i.pinimg.com/564x/5d/69/42/5d6942c6dff12bd3f960eb30c5fdd0f9.jpg",
                                                            fit: BoxFit.cover,
                                                            height: 150.0,
                                                            width: 100.0,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child: Align(
                                                        alignment: Alignment
                                                            .bottomLeft,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 5,
                                                                  left: 3),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              MyText(
                                                                  color: white,
                                                                  fontsize: 12,
                                                                  fontwaight:
                                                                      FontWeight
                                                                          .w600,
                                                                  text: relatedvideoprovider
                                                                          .relatedvideomodel
                                                                          .result?[
                                                                              index]
                                                                          .name
                                                                          .toString() ??
                                                                      "",
                                                                  textalign:
                                                                      TextAlign
                                                                          .left,
                                                                  maxline: 2,
                                                                  fontstyle:
                                                                      FontStyle
                                                                          .normal),
                                                              const SizedBox(
                                                                height: 5,
                                                              ),
                                                              MyText(
                                                                  color:
                                                                      danceclassesTextYellow,
                                                                  fontsize: 10,
                                                                  fontwaight:
                                                                      FontWeight
                                                                          .w400,
                                                                  text: Utils().dateConvert(
                                                                      relatedvideoprovider
                                                                          .relatedvideomodel
                                                                          .result![
                                                                              index]
                                                                          .createdAt
                                                                          .toString(),
                                                                      "MMM dd yyyy"),
                                                                  textalign:
                                                                      TextAlign
                                                                          .center,
                                                                  fontstyle:
                                                                      FontStyle
                                                                          .normal),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              debugPrint("Click");
                              await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Addcommentpopup(
                                      userid: userid,
                                      videoid: widget.videoid,
                                    );
                                  });

                              videobyidprovider.viewcomment(widget.videoid);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 100,
                              alignment: Alignment.center,
                              child: Container(
                                width: 250,
                                height: 45,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                  gradient: LinearGradient(
                                      colors: [addcommentOne, addcommentTwo]),
                                ),
                                child: Consumer<ApiProvider>(builder:
                                    (context, viewcommentprovider, child) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      MyImage(
                                          width: 20,
                                          height: 20,
                                          imagePath:
                                              "assets/images/countComment.png"),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      MyText(
                                          color: white,
                                          text:
                                              '${(viewcommentprovider.viewcommentmodel.result?.length ?? 0)} ',
                                          fontsize: 12,
                                          fontwaight: FontWeight.w600,
                                          maxline: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textalign: TextAlign.left,
                                          fontstyle: FontStyle.normal),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        width: 1,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        margin: const EdgeInsets.only(
                                            top: 5, bottom: 5),
                                        color: white,
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      LanguageText(
                                          color: white,
                                          text: "addcomment",
                                          fontsize: 14,
                                          fontwaight: FontWeight.w600,
                                          maxline: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textalign: TextAlign.left,
                                          fontstyle: FontStyle.normal),
                                    ],
                                  );
                                }),
                              ),
                            ),
                          ),
                          MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            removeBottom: true,
                            child: Consumer<ApiProvider>(
                                builder: (context, viewcommentprovider, child) {
                              return ListView.separated(
                                controller: _scrollcontroller,
                                itemCount: viewcommentprovider
                                        .viewcommentmodel.result?.length ??
                                    0,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                    color: primary,
                                    elevation: 0,
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 3),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      // ignore: unrelated_type_equality_checks
                                                      child: MyNetworkImage(
                                                          width: 50,
                                                          height: 50,
                                                          fit: BoxFit.fill,
                                                          imagePath: viewcommentprovider
                                                                  .viewcommentmodel
                                                                  .result?[
                                                                      index]
                                                                  .image
                                                                  .toString() ??
                                                              "https://i.pinimg.com/564x/5d/69/42/5d6942c6dff12bd3f960eb30c5fdd0f9.jpg"),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 4,
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        MyText(
                                                            color: white,
                                                            text: viewcommentprovider
                                                                    .viewcommentmodel
                                                                    .result?[
                                                                        index]
                                                                    .fullname ??
                                                                "",
                                                            fontsize: 16,
                                                            fontwaight:
                                                                FontWeight.w500,
                                                            maxline: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textalign: TextAlign
                                                                .center,
                                                            fontstyle: FontStyle
                                                                .normal),
                                                        const SizedBox(
                                                            height: 5),
                                                        MyText(
                                                            color: white,
                                                            text: viewcommentprovider
                                                                    .viewcommentmodel
                                                                    .result?[
                                                                        index]
                                                                    .comment ??
                                                                "",
                                                            fontsize: 14,
                                                            fontwaight:
                                                                FontWeight.w500,
                                                            maxline: 6,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textalign:
                                                                TextAlign.left,
                                                            fontstyle: FontStyle
                                                                .normal),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const Divider(
                                    height: 1,
                                    thickness: 0.5,
                                    color: commentdividerline,
                                  );
                                },
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return const NoData();
              }
            }
          },
        ),
      ),
    );
  }

  Widget detailshimmer() {
    return Column(children: [
      Stack(
        children: [
          // Background Image
          Container(
            width: MediaQuery.of(context).size.width,
            height: 420,
            foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  detailpagegradiantOne.withOpacity(0.2),
                  detailpagegradiantTwo.withOpacity(1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.5, 2],
              ),
            ),
          ),
          SizedBox(
            height: 400,
            width: MediaQuery.of(context).size.width,
            child: const Align(
              alignment: Alignment.center,
              child: CustomWidget.circular(width: 70, height: 70),
            ),
          ),
          SizedBox(
            height: 400,
            width: MediaQuery.of(context).size.width,
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 50, 0, 0),
                child: Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.centerLeft,
                  child: const CustomWidget.circular(height: 40, width: 40),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 400,
            width: MediaQuery.of(context).size.width,
            child: const Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
                  child: CustomWidget.roundrectborder(
                    height: 20,
                    width: 200,
                  )),
            ),
          ),
          SizedBox(
            height: 400,
            width: MediaQuery.of(context).size.width,
            child: const Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 70),
                  child: CustomWidget.roundrectborder(height: 20, width: 100)),
            ),
          ),
          SizedBox(
            height: 420,
            width: MediaQuery.of(context).size.width,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(65, 0, 0, 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    CustomWidget.roundrectborder(height: 20, width: 130),
                    SizedBox(height: 5),
                    CustomWidget.roundrectborder(height: 25, width: 150),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 420,
            width: MediaQuery.of(context).size.width,
            child: const Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 0, 25),
                child: CustomWidget.circular(height: 40, width: 40),
              ),
            ),
          ),
        ],
      ),
      Column(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 150,
          margin: const EdgeInsets.only(left: 15),
          child: Column(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  alignment: Alignment.centerLeft,
                  child: const CustomWidget.roundrectborder(
                      height: 15, width: 100),
                ),
              ),
              Flexible(
                flex: 3,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  alignment: Alignment.topLeft,
                  child: CustomWidget.roundrectborder(
                      height: 20, width: MediaQuery.of(context).size.width),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 80,
          margin: const EdgeInsets.only(left: 15),
          child: Row(
            children: const [
              CustomWidget.circular(height: 55, width: 55),
              SizedBox(
                width: 20,
              ),
              CustomWidget.circular(height: 55, width: 55),
              SizedBox(
                width: 20,
              ),
              CustomWidget.circular(height: 55, width: 55),
            ],
          ),
        ),
        Container(
          height: 45,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(left: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              CustomWidget.rectangular(height: 25, width: 70),
              SizedBox(
                width: 10,
              ),
              CustomWidget.rectangular(height: 25, width: 70),
            ],
          ),
        ),
        InkWell(
          onTap: () {},
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            alignment: Alignment.center,
            child: const CustomWidget.circular(height: 45, width: 250),
          ),
        ),
        ListView.builder(
          itemCount: 5,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: primary,
              elevation: 0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 90,
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 89,
                      margin: const EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              padding: const EdgeInsets.only(top: 3),
                              alignment: Alignment.topLeft,
                              child: const CustomWidget.circular(
                                height: 40,
                                width: 40,
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 4,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              alignment: Alignment.centerLeft,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  CustomWidget.roundrectborder(
                                    height: 10,
                                    width: 100,
                                  ),
                                  SizedBox(height: 5),
                                  CustomWidget.roundrectborder(
                                    height: 10,
                                    width: 100,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 1,
                      margin: const EdgeInsets.only(left: 15, right: 15),
                      color: commentdividerline,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 20,
          padding: const EdgeInsets.only(right: 15),
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () {},
            child: const CustomWidget.roundrectborder(
              height: 10,
              width: 50,
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 250,
          color: primary,
          alignment: Alignment.center,
          child: Column(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  alignment: Alignment.center,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      alignment: Alignment.centerLeft,
                      child: const CustomWidget.roundrectborder(
                        height: 10,
                        width: 100,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  alignment: Alignment.center,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return const Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                        child: CustomWidget.roundcorner(
                          height: 200,
                          width: 120,
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ])
    ]);
  }
}
