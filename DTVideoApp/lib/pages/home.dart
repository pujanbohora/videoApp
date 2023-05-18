import 'dart:async';
import 'dart:developer';
import 'package:dtvideo/pages/category.dart';
import 'package:dtvideo/pages/albumn.dart';
import 'package:dtvideo/pages/detailspage.dart';
import 'package:dtvideo/pages/favouritevideo.dart';
import 'package:dtvideo/pages/foryou.dart';
import 'package:dtvideo/pages/login.dart';
import 'package:dtvideo/pages/profile.dart';
import 'package:dtvideo/pages/pushnotification.dart';
import 'package:dtvideo/pages/search.dart';
import 'package:dtvideo/pages/trandingvideo.dart';
import 'package:dtvideo/pages/videos.dart';
import 'package:dtvideo/provider/apiprovider.dart';
import 'package:dtvideo/utils/adhelper.dart';
import 'package:dtvideo/utils/color.dart';
import 'package:dtvideo/utils/customwidget.dart';
import 'package:dtvideo/utils/sharedpre.dart';
import 'package:dtvideo/widget/ibarraText.dart';
import 'package:dtvideo/widget/language.dart';
import 'package:dtvideo/widget/myimage.dart';
import 'package:dtvideo/widget/mynetworkimg.dart';
import 'package:dtvideo/widget/mytext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  SharedPre sharePref = SharedPre();
  RewardedAd? rewardedAd;

  PageController pageController = PageController();
  final currentPageNotifier = ValueNotifier<int>(0);
  final searchController = TextEditingController();
  late int pos;
  bool isVisible = true;
  bool ischange = true;

  bool visibility = true;
  String userid = "";

  var androidBannerAdsId = "";
  var iosBannerAdsId = "";
  var bannerad = "";
  var banneradIos = "";

  @override
  void initState() {
    super.initState();
    getuserid();
    getId();
  }

  getId() async {
    androidBannerAdsId = await sharePref.read("banner_adid") ?? "";
    iosBannerAdsId = await sharePref.read("ios_banner_adid") ?? "";
    bannerad = await sharePref.read("banner_ad") ?? "";
    banneradIos = await sharePref.read("ios_banner_ad") ?? "";

    debugPrint("Android id:====$bannerad");
    debugPrint("ios id:====$banneradIos");
  }

  getuserid() async {
    userid = await sharePref.read("userid") ?? "";
    debugPrint("HomePage UserID:$userid");

    // ignore: use_build_context_synchronously
    final homeitem = Provider.of<ApiProvider>(context, listen: false);
    homeitem.getUserId();
    // ignore: use_build_context_synchronously
    homeitem.artistlist(context);
    // ignore: use_build_context_synchronously
    homeitem.latestvideo(context);
    // ignore: use_build_context_synchronously
    homeitem.feturevideo(context);
    // ignore: use_build_context_synchronously
    homeitem.albumn(context);
    // ignore: use_build_context_synchronously
    homeitem.mostviewvideo(context);
    // ignore: use_build_context_synchronously
    homeitem.categorylist(context);

    if (userid.isNotEmpty || userid != "") {
      homeitem.favouritelist(userid);
      await homeitem.profile();

      if (homeitem.loading) {
        log("===>loading ${homeitem.loading}");
        await sharePref.save(
            "is_buy", homeitem.profilemodel.result![0].isbuy.toString());
      }
    }

    AdHelper.createInterstitialAd();
    AdHelper.createRewardedAd();
  }

  Widget setlogo() {
    if (pos == 0) {
      return MyImage(
          width: 15, height: 15, imagePath: "assets/images/wifi.png");
    } else if (pos == 1) {
      return MyImage(
          width: 15, height: 15, imagePath: "assets/images/wifi.png");
    } else {
      return const Text("");
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Called Home Build");

    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: primary,
        title: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child: Row(
            children: [
              LanguageText(
                  color: white,
                  text: "dtvideo",
                  fontsize: 16,
                  fontwaight: FontWeight.w600,
                  textalign: TextAlign.center,
                  fontstyle: FontStyle.normal),
              const Spacer(),
              InkWell(
                onTap: () {
                  if (userid.isEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Pushnotification()),
                    );
                  }
                },
                child: MyImage(
                  width: 20,
                  height: 20,
                  imagePath: "assets/images/notification.png",
                ),
              ),
              const SizedBox(width: 10)
            ],
          ),
        ),
      ),
      body: RefreshIndicator(
        displacement: 300,
        backgroundColor: primary,
        color: white,
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        strokeWidth: 3,
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 1000));
          // ignore: use_build_context_synchronously
          final homeitem = Provider.of<ApiProvider>(context, listen: false);
          // ignore: use_build_context_synchronously
          homeitem.artistlist(context);
          // ignore: use_build_context_synchronously
          homeitem.latestvideo(context);
          // ignore: use_build_context_synchronously
          homeitem.feturevideo(context);
          // ignore: use_build_context_synchronously
          homeitem.categorylist(context);
          // ignore: use_build_context_synchronously
          homeitem.mostviewvideo(context);
          debugPrint("HomePage UserID:$userid");
          homeitem.favouritelist(userid);
          homeitem.profile();
        },
        child: SingleChildScrollView(
          child: Container(
            color: primary,
            child: Column(
              children: [
                searchbar(),
                artist(),
                latestVideo(),
                forYou(),
                albumn(),
                trandingVideo(),
                category(),
                favouriteVideo(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget searchbar() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      color: primary,
      alignment: Alignment.center,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.fromLTRB(20, 6, 20, 6),
        decoration: BoxDecoration(
            color: homesearchbar,
            border: Border.all(
              color: homesearchbar,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(7))),
        child: Row(children: [
          Flexible(
            flex: 1,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 20,
              child: Image.asset("assets/images/search.png",
                  width: 10, height: 10),
            ),
          ),
          Flexible(
            flex: 6,
            child: Center(
              child: TextField(
                textInputAction: TextInputAction.done,
                obscureText: false,
                controller: searchController,
                showCursor: true,
                // focusNode: false,
                readOnly: true,
                // keyboardType: false,
                maxLines: 1,
                onChanged: (value) {
                  Provider.of<ApiProvider>(context, listen: false)
                      .search(searchController.text);
                },
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const Search();
                      },
                    ),
                  );
                },
                style: GoogleFonts.inter(
                  color: white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  // fillColor: white,
                  hintStyle: GoogleFonts.inter(
                      color: white, fontSize: 14, fontWeight: FontWeight.w500),
                  hintText: "search what ever you like...",
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget artist() {
    return Consumer<ApiProvider>(
      builder: (context, artistlistprovider, child) {
        if (!artistlistprovider.loading) {
          return artistshimmer();
        } else {
          if (artistlistprovider.artistlistmodel.status == 200 &&
              artistlistprovider.artistlistmodel.result?.length != null) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: 120,
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
                        child: Row(
                          children: [
                            LanguageText(
                                color: white,
                                text: "TopUsers",
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
                  Flexible(
                    flex: 2,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      alignment: Alignment.center,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount:
                            artistlistprovider.artistlistmodel.result?.length,
                        itemBuilder: (BuildContext context, int index) {
                          debugPrint("List Index:$index");
                          pos = index;
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Profile(
                                          artistid: artistlistprovider
                                                  .artistlistmodel
                                                  .result?[index]
                                                  .id
                                                  .toString() ??
                                              "",
                                        )),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Container(
                                width: 50,
                                height: MediaQuery.of(context).size.height,
                                alignment: Alignment.center,
                                child: Stack(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: primary,
                                        border: Border.all(
                                          color:
                                              borderhome, // red as border color
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          child: MyNetworkImage(
                                              imagePath: artistlistprovider
                                                      .artistlistmodel
                                                      .result?[index]
                                                      .image
                                                      .toString() ??
                                                  "https://i.pinimg.com/564x/5d/69/42/5d6942c6dff12bd3f960eb30c5fdd0f9.jpg",
                                              width: 45,
                                              fit: BoxFit.cover,
                                              height: 45),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: setlogo(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container(
              height: 1,
            );
          }
        }
      },
    );
  }

  Widget artistshimmer() {
    return Container(
      height: 120,
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              CustomWidget.circular(
                width: 50,
                height: 50,
              ),
            ],
          );
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget latestVideo() {
    return Consumer<ApiProvider>(
      builder: (context, latestvideoprovider, child) {
        if (!latestvideoprovider.loading) {
          return latestshimmer();
        } else {
          if (latestvideoprovider.latestvideomodel.status == 200 &&
              latestvideoprovider.latestvideomodel.result?.length != null) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: 220,
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
                        child: Row(
                          children: [
                            LanguageText(
                                color: white,
                                text: "latestvideo",
                                fontsize: 16,
                                fontwaight: FontWeight.w600,
                                textalign: TextAlign.center,
                                fontstyle: FontStyle.normal),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 170,
                            margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                            child: PageView.builder(
                              itemCount: latestvideoprovider
                                  .latestvideomodel.result?.length,
                              scrollDirection: Axis.horizontal,
                              controller: pageController,
                              reverse: false,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    AdHelper.showRewardedAd();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailsPage(
                                          videoid: latestvideoprovider
                                                  .latestvideomodel
                                                  .result?[index]
                                                  .id
                                                  .toString() ??
                                              "",
                                          catid: latestvideoprovider
                                                  .latestvideomodel
                                                  .result?[index]
                                                  .categoryId
                                                  .toString() ??
                                              "",
                                        ),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Stack(
                                      alignment: Alignment.topLeft,
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentDirectional.center,
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20)),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              foregroundDecoration:
                                                  BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(20),
                                                        topRight:
                                                            Radius.circular(
                                                                20)),
                                                color: white,
                                                gradient: LinearGradient(
                                                  colors: [
                                                    latestdancegradiantOne
                                                        .withOpacity(0.2),
                                                    latestdancegradiantTwo
                                                        .withOpacity(0.9),
                                                  ],
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  stops: const [0.6, 2],
                                                ),
                                              ),
                                              child: MyNetworkImage(
                                                fit: BoxFit.fill,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height,
                                                imagePath: latestvideoprovider
                                                        .latestvideomodel
                                                        .result?[index]
                                                        .image
                                                        .toString() ??
                                                    "https://i.pinimg.com/564x/5d/69/42/5d6942c6dff12bd3f960eb30c5fdd0f9.jpg",
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          child: Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, bottom: 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  IbarraText(
                                                    text: latestvideoprovider
                                                            .latestvideomodel
                                                            .result?[index]
                                                            .name
                                                            .toString() ??
                                                        "https://i.pinimg.com/564x/5d/69/42/5d6942c6dff12bd3f960eb30c5fdd0f9.jpg",
                                                    maxline: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textalign: TextAlign.center,
                                                    color: white,
                                                    fontsize: 10,
                                                    fontstyle: FontStyle.normal,
                                                    fontwaight: FontWeight.w400,
                                                  ),
                                                  const SizedBox(
                                                    height: 7,
                                                  ),
                                                  Container(
                                                    width: 70,
                                                    height: 20,
                                                    alignment: Alignment.center,
                                                    decoration:
                                                        const BoxDecoration(
                                                            color:
                                                                watchnowcolor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            3))),
                                                    child: MyText(
                                                        color: white,
                                                        text: "Watch Now",
                                                        fontsize: 9,
                                                        fontwaight:
                                                            FontWeight.w500,
                                                        textalign:
                                                            TextAlign.center,
                                                        fontstyle:
                                                            FontStyle.normal),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5, left: 10, right: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  MyImage(
                                                      width: 15,
                                                      height: 15,
                                                      imagePath:
                                                          "assets/images/star.png"),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  MyText(
                                                      color: homepageviewtext,
                                                      text: latestvideoprovider
                                                              .latestvideomodel
                                                              .result?[index]
                                                              .categoryName
                                                              .toString() ??
                                                          "",
                                                      fontsize: 10,
                                                      fontwaight:
                                                          FontWeight.w400,
                                                      textalign:
                                                          TextAlign.center,
                                                      fontstyle:
                                                          FontStyle.normal),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 5, right: 5),
                                                child: MyImage(
                                                    width: 15,
                                                    height: 15,
                                                    imagePath:
                                                        "assets/images/play.png")),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              onPageChanged: (index) {},
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 170,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: SmoothPageIndicator(
                                  controller: pageController,
                                  count: latestvideoprovider
                                      .latestvideomodel.result!.length,
                                  effect: const WormEffect(
                                      spacing: 5,
                                      radius: 1,
                                      dotWidth: 12,
                                      dotColor: intronextBtn,
                                      dotHeight: 3,
                                      activeDotColor: white),
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
            );
          } else {
            return Container(
              height: 1,
            );
          }
        }
      },
    );
  }

  Widget latestshimmer() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 220,
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              CustomWidget.roundcorner(
                width: 320,
                height: 170,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget forYou() {
    return Consumer<ApiProvider>(
      builder: (context, featurevideoprovider, child) {
        if (!featurevideoprovider.loading) {
          return foryoushimmer();
        } else {
          if (featurevideoprovider.videomodel.status == 200 &&
              featurevideoprovider.videomodel.result?.length != null) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
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
                        child: Row(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height,
                              alignment: Alignment.centerLeft,
                              child: LanguageText(
                                  color: white,
                                  text: "foryou",
                                  fontsize: 16,
                                  fontwaight: FontWeight.w600,
                                  textalign: TextAlign.center,
                                  fontstyle: FontStyle.normal),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                AdHelper.showInterstitialAd();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Foryou()),
                                );
                              },
                              child: Container(
                                height: MediaQuery.of(context).size.height,
                                alignment: Alignment.centerRight,
                                child: LanguageText(
                                    color: white,
                                    text: "seeall",
                                    fontsize: 12,
                                    fontwaight: FontWeight.w600,
                                    textalign: TextAlign.center,
                                    fontstyle: FontStyle.normal),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    child: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          color: primary,
                          margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          alignment: Alignment.center,
                          child: PageView.builder(
                            itemCount:
                                featurevideoprovider.videomodel.result?.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  AdHelper.showRewardedAd();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return DetailsPage(
                                          videoid: featurevideoprovider
                                                  .videomodel.result?[index].id
                                                  .toString() ??
                                              "",
                                          catid: featurevideoprovider.videomodel
                                                  .result?[index].categoryId
                                                  .toString() ??
                                              "",
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Stack(
                                    alignment: Alignment.topLeft,
                                    children: [
                                      Align(
                                        alignment: AlignmentDirectional.center,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(24.0),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            foregroundDecoration: BoxDecoration(
                                              color: white,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(24)),
                                              gradient: LinearGradient(
                                                colors: [
                                                  foryougradiantOne
                                                      .withOpacity(0.2),
                                                  foryougradiantTwo
                                                      .withOpacity(0.8),
                                                ],
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                stops: const [0.5, 2],
                                              ),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                              child: MyNetworkImage(
                                                imagePath: featurevideoprovider
                                                        .videomodel
                                                        .result?[index]
                                                        .image
                                                        .toString() ??
                                                    "https://i.pinimg.com/564x/5d/69/42/5d6942c6dff12bd3f960eb30c5fdd0f9.jpg",
                                                fit: BoxFit.cover,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        child: Align(
                                            alignment: Alignment.center,
                                            child: MyImage(
                                                width: 50,
                                                height: 50,
                                                imagePath:
                                                    "assets/images/videoplay.png")),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        child: Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 15, left: 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                MyText(
                                                    color: white,
                                                    fontsize: 16,
                                                    fontwaight: FontWeight.w600,
                                                    text: featurevideoprovider
                                                            .videomodel
                                                            .result?[index]
                                                            .name
                                                            .toString() ??
                                                        "",
                                                    textalign: TextAlign.center,
                                                    fontstyle:
                                                        FontStyle.normal),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                IbarraText(
                                                  text: featurevideoprovider
                                                          .videomodel
                                                          .result?[index]
                                                          .artistName
                                                          .toString() ??
                                                      "",
                                                  maxline: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textalign: TextAlign.center,
                                                  color: foryouYellow,
                                                  fontsize: 17,
                                                  fontstyle: FontStyle.normal,
                                                  fontwaight: FontWeight.w600,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned.fill(
                                        top: 10,
                                        left: 15,
                                        right: 15,
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    ischange = !ischange;
                                                    likeDislikelogo();
                                                  });
                                                },
                                                child: likeDislikelogo(),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              MyImage(
                                                  width: 30,
                                                  height: 30,
                                                  imagePath:
                                                      "assets/images/share.png"),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container(
              height: 1,
            );
          }
        }
      },
    );
  }

  Widget foryoushimmer() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 250,
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              CustomWidget.roundcorner(
                width: 320,
                height: 240,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget albumn() {
    return Consumer<ApiProvider>(
      builder: (context, albumnprovider, child) {
        if (!albumnprovider.loading) {
          return albumnshimmer();
        } else {
          if (albumnprovider.albumnmodel.status == 200 &&
              (albumnprovider.albumnmodel.result?.length ?? 0) > 0) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
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
                        child: Row(
                          children: [
                            LanguageText(
                                color: white,
                                text: "albums",
                                fontsize: 16,
                                fontwaight: FontWeight.w600,
                                textalign: TextAlign.center,
                                fontstyle: FontStyle.normal),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                AdHelper.showInterstitialAd();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Albumn()),
                                );
                              },
                              child: LanguageText(
                                  color: white,
                                  text: "seeall",
                                  fontsize: 12,
                                  fontwaight: FontWeight.w600,
                                  textalign: TextAlign.center,
                                  fontstyle: FontStyle.normal),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        alignment: Alignment.centerLeft,
                        // margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: albumnprovider.albumnmodel.result?.length,
                          itemBuilder: (BuildContext context, int index) {
                            final DateTime now = DateTime.parse(albumnprovider
                                    .albumnmodel.result?[index].createdAt
                                    .toString() ??
                                "");
                            final DateFormat formatter =
                                DateFormat('MMM d yyyy');
                            final String formatted = formatter.format(now);

                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return Videos(
                                        id: albumnprovider
                                                .albumnmodel.result?[index].id
                                                .toString() ??
                                            "",
                                        type: "album",
                                        name: albumnprovider
                                                .albumnmodel.result?[index].name
                                                .toString() ??
                                            "",
                                      );
                                    },
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                child: Container(
                                  width: 120,
                                  height: 220,
                                  //  color: danceclasess,
                                  decoration: BoxDecoration(
                                    color: danceclasess,
                                    border: Border.all(
                                      color: danceclasess,
                                    ),
                                    borderRadius: BorderRadius.circular(11.0),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(7),
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            foregroundDecoration: BoxDecoration(
                                              color: white,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(8)),
                                              gradient: LinearGradient(
                                                colors: [
                                                  danceclassisgradiantOne
                                                      .withOpacity(0.2),
                                                  danceclassisgradiantTwo
                                                      .withOpacity(0.8),
                                                ],
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                stops: const [0.5, 2],
                                              ),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: MyNetworkImage(
                                                imagePath: albumnprovider
                                                        .albumnmodel
                                                        .result?[index]
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
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          child: Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 5, left: 3),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  MyText(
                                                      color: white,
                                                      fontsize: 8,
                                                      fontwaight:
                                                          FontWeight.w600,
                                                      text: albumnprovider
                                                              .albumnmodel
                                                              .result?[index]
                                                              .name
                                                              .toString() ??
                                                          "",
                                                      textalign:
                                                          TextAlign.center,
                                                      fontstyle:
                                                          FontStyle.normal),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  MyText(
                                                      color:
                                                          danceclassesTextYellow,
                                                      fontsize: 6,
                                                      fontwaight:
                                                          FontWeight.w400,
                                                      text: formatted,
                                                      textalign:
                                                          TextAlign.center,
                                                      fontstyle:
                                                          FontStyle.normal),
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
                        )),
                  ),
                ],
              ),
            );
          } else {
            return Container(height: 1);
          }
        }
      },
    );
  }

  Widget albumnshimmer() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
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
                child: Row(
                  children: [
                    Flexible(
                      flex: 6,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        alignment: Alignment.centerLeft,
                        child: MyText(
                            color: white,
                            text: "Albums",
                            fontsize: 16,
                            fontwaight: FontWeight.w600,
                            textalign: TextAlign.center,
                            fontstyle: FontStyle.normal),
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        alignment: Alignment.center,
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: InkWell(
                        onTap: () {
                          debugPrint("Click");
                          AdHelper.showInterstitialAd();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Albumn()),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          alignment: Alignment.centerRight,
                          child: MyText(
                              color: white,
                              text: "See All",
                              fontsize: 12,
                              fontwaight: FontWeight.w600,
                              textalign: TextAlign.center,
                              fontstyle: FontStyle.normal),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.centerLeft,
                // margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Container(
                        width: 120,
                        height: 220,
                        //  color: danceclasess,
                        decoration: BoxDecoration(
                          color: danceclasess,
                          border: Border.all(
                            color: danceclasess,
                          ),
                          borderRadius: BorderRadius.circular(11.0),
                        ),
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(7),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  foregroundDecoration: BoxDecoration(
                                    color: white,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                    gradient: LinearGradient(
                                      colors: [
                                        danceclassisgradiantOne
                                            .withOpacity(0.2),
                                        danceclassisgradiantTwo
                                            .withOpacity(0.8),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      stops: const [0.5, 2],
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: const CustomWidget.rectangular(
                                      height: 150,
                                      width: 100,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }

  Widget trandingVideo() {
    return Consumer<ApiProvider>(
        builder: (context, artistvideoprovider, child) {
      if (!artistvideoprovider.loading) {
        return trandingshimmer();
      } else {
        if (artistvideoprovider.mostviewvideomodel.status == 200 &&
            artistvideoprovider.mostviewvideomodel.result?.length != null) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 270,
            color: primary,
            alignment: Alignment.center,
            child: Column(
              children: [
                Flexible(
                  flex: 2,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    alignment: Alignment.center,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Row(
                        children: [
                          LanguageText(
                              color: white,
                              text: "trandingvideo",
                              fontsize: 16,
                              fontwaight: FontWeight.w600,
                              textalign: TextAlign.center,
                              fontstyle: FontStyle.normal),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              AdHelper.showInterstitialAd();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const Trandingvideo()),
                              );
                            },
                            child: LanguageText(
                                color: white,
                                text: "seeall",
                                fontsize: 12,
                                fontwaight: FontWeight.w600,
                                textalign: TextAlign.center,
                                fontstyle: FontStyle.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 8,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: primary,
                    margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    alignment: Alignment.center,
                    child: PageView.builder(
                      itemCount:
                          artistvideoprovider.mostviewvideomodel.result?.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            AdHelper.showRewardedAd();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return DetailsPage(
                                      videoid: artistvideoprovider
                                              .mostviewvideomodel
                                              .result?[index]
                                              .id
                                              .toString() ??
                                          "",
                                      catid: artistvideoprovider
                                              .mostviewvideomodel
                                              .result?[index]
                                              .categoryId
                                              .toString() ??
                                          "");
                                },
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Stack(
                              alignment: Alignment.topLeft,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  alignment: AlignmentDirectional.center,
                                  decoration: const BoxDecoration(
                                    color: primary,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(11)),
                                    border: GradientBoxBorder(
                                        width: 4,
                                        gradient: LinearGradient(colors: [
                                          artistVideogradiantBorderOne,
                                          artistVideogradiantBorderTwo
                                        ])),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      foregroundDecoration: BoxDecoration(
                                        color: white,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        gradient: LinearGradient(
                                          colors: [
                                            artistvideogradiantOne
                                                .withOpacity(0.2),
                                            artistvideogradiantTwo
                                                .withOpacity(0.9),
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          stops: const [0.5, 2],
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: MyNetworkImage(
                                          imagePath: artistvideoprovider
                                                  .mostviewvideomodel
                                                  .result?[index]
                                                  .image
                                                  .toString() ??
                                              "https://i.pinimg.com/564x/5d/69/42/5d6942c6dff12bd3f960eb30c5fdd0f9.jpg",
                                          fit: BoxFit.cover,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                        ),
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
                                          width: 50,
                                          height: 50,
                                          imagePath:
                                              "assets/images/videoplay.png")),
                                ),
                                Positioned.fill(
                                  left: 15,
                                  right: 15,
                                  top: 10,
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Provider.of<ApiProvider>(context,
                                                    listen: false)
                                                .addfavourite(
                                                    artistvideoprovider
                                                        .mostviewvideomodel
                                                        .result?[index]
                                                        .id,
                                                    userid);
                                            Provider.of<ApiProvider>(context,
                                                    listen: false)
                                                .chackfavourite(
                                                    artistvideoprovider
                                                        .mostviewvideomodel
                                                        .result?[index]
                                                        .id,
                                                    userid);
                                          },
                                          child: MyImage(
                                              width: 30,
                                              height: 30,
                                              imagePath:
                                                  "assets/images/like.png"),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        MyImage(
                                            width: 30,
                                            height: 30,
                                            imagePath:
                                                "assets/images/share.png"),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IbarraText(
                                            text: artistvideoprovider
                                                    .mostviewvideomodel
                                                    .result?[index]
                                                    .name
                                                    .toString() ??
                                                "",
                                            maxline: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textalign: TextAlign.center,
                                            color: white,
                                            fontsize: 18,
                                            fontstyle: FontStyle.normal,
                                            fontwaight: FontWeight.w600,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              MyImage(
                                                  width: 10,
                                                  height: 10,
                                                  imagePath:
                                                      "assets/images/staryellow.png"),
                                              const SizedBox(
                                                width: 2,
                                              ),
                                              MyImage(
                                                  width: 10,
                                                  height: 10,
                                                  imagePath:
                                                      "assets/images/staryellow.png"),
                                              const SizedBox(
                                                width: 2,
                                              ),
                                              MyImage(
                                                  width: 10,
                                                  height: 10,
                                                  imagePath:
                                                      "assets/images/staryellow.png"),
                                              const SizedBox(
                                                width: 2,
                                              ),
                                              MyImage(
                                                  width: 10,
                                                  height: 10,
                                                  imagePath:
                                                      "assets/images/staryellow.png"),
                                              const SizedBox(
                                                width: 2,
                                              ),
                                              MyImage(
                                                  width: 10,
                                                  height: 10,
                                                  imagePath:
                                                      "assets/images/stargray.png"),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container(
            height: 1,
          );
        }
      }
    });
  }

  Widget trandingshimmer() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 270,
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              CustomWidget.roundcorner(
                width: 320,
                height: 200,
              ),
            ],
          );
        },
      ),
    );
  }

// Category
  Widget category() {
    return Consumer<ApiProvider>(builder: (context, categoryprovider, child) {
      if (!categoryprovider.loading) {
        return categoryshimmer();
      } else {
        if (categoryprovider.categorylistmodel.status == 200 &&
            (categoryprovider.categorylistmodel.result?.length ?? 0) > 0) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 180,
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
                      child: Row(
                        children: [
                          LanguageText(
                              color: white,
                              text: "category",
                              fontsize: 16,
                              fontwaight: FontWeight.w600,
                              textalign: TextAlign.center,
                              fontstyle: FontStyle.normal),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              AdHelper.showInterstitialAd();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Categorypage()),
                              );
                            },
                            child: LanguageText(
                                color: white,
                                text: "seeall",
                                fontsize: 12,
                                fontwaight: FontWeight.w600,
                                textalign: TextAlign.center,
                                fontstyle: FontStyle.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount:
                        categoryprovider.categorylistmodel.result?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Videos(
                                  id: categoryprovider
                                          .categorylistmodel.result?[index].id
                                          .toString() ??
                                      "",
                                  type: "category",
                                  name: categoryprovider
                                          .categorylistmodel.result?[index].name
                                          .toString() ??
                                      "",
                                );
                              },
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
                              child: Container(
                                width: 85,
                                height: 85,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: primary,
                                  border: const GradientBoxBorder(
                                      width: 4,
                                      gradient: LinearGradient(colors: [
                                        categorygradiantBorderOne,
                                        categorygradiantBorderTwo
                                      ])),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(7),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: MyNetworkImage(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      fit: BoxFit.cover,
                                      imagePath: categoryprovider
                                              .categorylistmodel
                                              .result?[index]
                                              .image
                                              .toString() ??
                                          "https://i.pinimg.com/564x/5d/69/42/5d6942c6dff12bd3f960eb30c5fdd0f9.jpg",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 80,
                              height: 20,
                              margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: Center(
                                child: IbarraText(
                                  text: categoryprovider
                                          .categorylistmodel.result?[index].name
                                          .toString() ??
                                      "",
                                  maxline: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textalign: TextAlign.center,
                                  color: white,
                                  fontsize: 12,
                                  fontstyle: FontStyle.normal,
                                  fontwaight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container(
            height: 1,
          );
        }
      }
    });
  }

  Widget categoryshimmer() {
    return Container(
      height: 120,
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                CustomWidget.circular(
                  width: 80,
                  height: 80,
                ),
              ],
            ),
          );
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget favouriteVideo() {
    return Consumer<ApiProvider>(
        builder: (context, favouritelistprovider, child) {
      if (!favouritelistprovider.loading) {
        debugPrint("shimmer");
        return favouriteshimmer();
      } else {
        log('===> Fav ${favouritelistprovider.favouritelistmodel.toString()}');
        if (favouritelistprovider.favouritelistmodel.status == 200 &&
            (favouritelistprovider.favouritelistmodel.result?.length ?? 0) >
                0) {
          debugPrint("if");

          return Container(
            width: MediaQuery.of(context).size.width,
            height: 240,
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
                      child: Row(
                        children: [
                          LanguageText(
                              color: white,
                              text: "favouritevideos",
                              fontsize: 16,
                              fontwaight: FontWeight.w600,
                              textalign: TextAlign.center,
                              fontstyle: FontStyle.normal),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              AdHelper.showInterstitialAd();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Favouritevideo()));
                            },
                            child: LanguageText(
                                color: white,
                                text: "seeall",
                                fontsize: 12,
                                fontwaight: FontWeight.w600,
                                textalign: TextAlign.center,
                                fontstyle: FontStyle.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    alignment: Alignment.centerLeft,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: favouritelistprovider
                              .favouritelistmodel.result?.length ??
                          0,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            if (userid.isEmpty) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Login()),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailsPage(
                                          videoid: favouritelistprovider
                                                  .favouritelistmodel
                                                  .result?[index]
                                                  .id ??
                                              "",
                                          catid: favouritelistprovider
                                                  .favouritelistmodel
                                                  .result?[index]
                                                  .categoryId ??
                                              "",
                                        )),
                              );
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 0, 5),
                            child: Stack(
                              children: [
                                Container(
                                  width: 160,
                                  height: 180,
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                    color: primary,
                                    border: const GradientBoxBorder(
                                        width: 4,
                                        gradient: LinearGradient(colors: [
                                          favouritegradiantBorderOne,
                                          favouritegradiantBorderTwo
                                        ])),
                                    borderRadius: BorderRadius.circular(14.0),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: MyNetworkImage(
                                      imagePath: favouritelistprovider
                                              .favouritelistmodel
                                              .result?[index]
                                              .image
                                              .toString() ??
                                          "https://i.pinimg.com/564x/5d/69/42/5d6942c6dff12bd3f960eb30c5fdd0f9.jpg",
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 160,
                                  height: 180,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: MyImage(
                                        width: 45,
                                        height: 45,
                                        imagePath: "assets/images/play.png"),
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(2, 0, 2, 0),
                                    child: SizedBox(
                                      width: 160,
                                      child: MyText(
                                          color: white,
                                          text: favouritelistprovider
                                                  .favouritelistmodel
                                                  .result?[index]
                                                  .name
                                                  .toString() ??
                                              "",
                                          fontsize: 12,
                                          maxline: 2,
                                          fontwaight: FontWeight.w500,
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
                  ),
                ),
              ],
            ),
          );
        } else {
          debugPrint("else");
          return Container();
        }
      }
    });
  }

  Widget favouriteshimmer() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 170,
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              CustomWidget.roundcorner(
                width: 140,
                height: 160,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget likeDislikelogo() {
    if (ischange == true) {
      ischange = false;
      return MyImage(
          width: 30, height: 30, imagePath: "assets/images/ic_fillheart.png");
    } else {
      ischange = true;
      return MyImage(
          width: 30, height: 30, imagePath: "assets/images/like.png");
    }
  }
}
