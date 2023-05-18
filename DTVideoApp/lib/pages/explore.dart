import 'dart:developer';

import 'package:dtvideo/model/explore.dart';
import 'package:dtvideo/pages/detailspage.dart';
import 'package:dtvideo/pages/search.dart';
import 'package:dtvideo/provider/apiprovider.dart';
import 'package:dtvideo/utils/color.dart';
import 'package:dtvideo/utils/customwidget.dart';
import 'package:dtvideo/widget/language.dart';
import 'package:dtvideo/widget/myimage.dart';
import 'package:dtvideo/widget/mynetworkimg.dart';
import 'package:dtvideo/widget/mytext.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  final searchController = TextEditingController();

  bool ischange = true;
  String userid = "3";
  String videoid = "17";
  int pageno = 0;
  List<Result>? explorelist = [];
  bool isLoadingVertical = false;

  @override
  void initState() {
    super.initState();
    pageno = 0;
    debugPrint("parameter:===$pageno");
    final exploreitem = Provider.of<ApiProvider>(context, listen: false);
    exploreitem.explore(pageno);
  }

  apicall() {
    pageno++;
    final exploreitem = Provider.of<ApiProvider>(context, listen: false);
    exploreitem.explore(pageno);
    return true;
  }

  Future _loadMoreVertical() async {
    apicall();
  }

  Widget changelogo() {
    if (ischange == true) {
      ischange = false;
      return MyImage(
          width: 20, height: 20, imagePath: "assets/images/gridicon.png");
    } else {
      ischange = true;
      return MyImage(
          width: 20, height: 20, imagePath: "assets/images/ic_list.png");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: LanguageText(
            color: white,
            text: "explore",
            fontsize: 16,
            fontwaight: FontWeight.w600,
            textalign: TextAlign.center,
            fontstyle: FontStyle.normal),
        backgroundColor: primary,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: primary,
        alignment: Alignment.center,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 5),
          child: Column(
            children: [
              // Searchbar
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                color: primary,
                alignment: Alignment.center,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  margin: const EdgeInsets.fromLTRB(0, 6, 0, 6),
                  decoration: BoxDecoration(
                      color: homesearchbar,
                      border: Border.all(
                        color: homesearchbar,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(7))),
                  child: Row(
                    children: [
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
                        flex: 7,
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
                                  color: white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                              hintText: "Search what ever you like...",
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              ischange = !ischange;
                              changelogo();
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            height: MediaQuery.of(context).size.width,
                            // gridicon
                            child: changelogo(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 20,
              ),
              Expanded(
                child: Consumer<ApiProvider>(
                    builder: (context, exploreProvider, child) {
                  if (!exploreProvider.loading) {
                    return exploreshimmer();
                  } else {
                    if (exploreProvider.exploremodel.status == 200 &&
                        (exploreProvider.exploremodel.result?.length ?? 0) >
                            0) {
                      explorelist?.addAll(
                          exploreProvider.exploremodel.result!.toList());
                      log('===>List ${explorelist!.length}');
                    }
                    return LazyLoadScrollView(
                      onEndOfPage: () => _loadMoreVertical(),
                      scrollOffset: 100,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: ischange == true ? 2 : 1,
                            childAspectRatio: 1,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                        itemCount: explorelist?.length ?? 0,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          log('==> ${explorelist?[index].categoryId.toString()}');
                          return ischange == true
                              ? InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return DetailsPage(
                                            videoid: explorelist?[index]
                                                    .id
                                                    .toString() ??
                                                "",
                                            catid: explorelist?[index]
                                                    .categoryId
                                                    .toString() ??
                                                "",
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    decoration: const BoxDecoration(
                                      color: primary,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: Stack(
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  20),
                                                          topLeft:
                                                              Radius.circular(
                                                                  20)),
                                                  child: MyNetworkImage(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .height,
                                                      fit: BoxFit.fill,
                                                      imagePath: explorelist?[
                                                                  index]
                                                              .image
                                                              .toString() ??
                                                          "https://i.pinimg.com/564x/5d/69/42/5d6942c6dff12bd3f960eb30c5fdd0f9.jpg"),
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height,
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: MyImage(
                                                      width: 50,
                                                      height: 50,
                                                      imagePath:
                                                          "assets/images/play.png"),
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height,
                                                child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(10, 5, 15, 0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        MyImage(
                                                            width: 20,
                                                            height: 20,
                                                            imagePath:
                                                                "assets/images/share.png"),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            debugPrint("Click");
                                                            Provider.of<ApiProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .addfavourite(
                                                                    videoid,
                                                                    userid);
                                                            Provider.of<ApiProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .chackfavourite(
                                                                    videoid,
                                                                    userid);
                                                          },
                                                          child: MyImage(
                                                              width: 20,
                                                              height: 20,
                                                              imagePath:
                                                                  "assets/images/like.png"),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                MyText(
                                                    color: white,
                                                    text: explorelist?[index]
                                                            .name
                                                            .toString() ??
                                                        "",
                                                    textalign: TextAlign.left,
                                                    fontsize: 12,
                                                    fontwaight: FontWeight.w600,
                                                    maxline: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontstyle:
                                                        FontStyle.normal),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                MyText(
                                                    color: exploresmalltext,
                                                    text: explorelist?[index]
                                                            .categoryName
                                                            .toString() ??
                                                        "",
                                                    textalign: TextAlign.center,
                                                    fontsize: 10,
                                                    fontwaight: FontWeight.w400,
                                                    maxline: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontstyle:
                                                        FontStyle.normal),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return DetailsPage(
                                            videoid: explorelist?[index]
                                                    .id
                                                    .toString() ??
                                                "",
                                            catid: explorelist?[index]
                                                    .categoryId
                                                    .toString() ??
                                                "",
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    decoration: const BoxDecoration(
                                      color: white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          foregroundDecoration: BoxDecoration(
                                            color: white,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20)),
                                            gradient: LinearGradient(
                                              colors: [
                                                foryougradiantOne
                                                    .withOpacity(0.2),
                                                foryougradiantTwo
                                                    .withOpacity(0.9),
                                              ],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              stops: const [0.5, 2],
                                            ),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: MyNetworkImage(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height,
                                                fit: BoxFit.fill,
                                                imagePath: explorelist?[index]
                                                        .image
                                                        .toString() ??
                                                    "https://i.pinimg.com/564x/5d/69/42/5d6942c6dff12bd3f960eb30c5fdd0f9.jpg"),
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: MyImage(
                                                width: 70,
                                                height: 70,
                                                imagePath:
                                                    "assets/images/play.png"),
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      15, 5, 15, 0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      // Add Favourite and Chackfavourite Api Call this Button
                                                      Provider.of<ApiProvider>(
                                                              context,
                                                              listen: false)
                                                          .addfavourite(
                                                              videoid, userid);
                                                      Provider.of<ApiProvider>(
                                                              context,
                                                              listen: false)
                                                          .chackfavourite(
                                                              videoid, userid);
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
                                                      fontwaight:
                                                          FontWeight.w600,
                                                      text: explorelist?[index]
                                                              .name
                                                              .toString() ??
                                                          "",
                                                      textalign:
                                                          TextAlign.center,
                                                      fontstyle:
                                                          FontStyle.normal),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  MyText(
                                                    text: explorelist?[index]
                                                            .categoryName
                                                            .toString() ??
                                                        "",
                                                    maxline: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textalign: TextAlign.center,
                                                    color: foryouYellow,
                                                    fontsize: 14,
                                                    fontstyle: FontStyle.normal,
                                                    fontwaight: FontWeight.w600,
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
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget exploreshimmer() {
    return GridView.count(
      crossAxisCount: ischange == true ? 2 : 1,
      crossAxisSpacing: 20,
      mainAxisSpacing: 15,
      shrinkWrap: true,
      children: List.generate(
        20,
        (index) {
          return ischange == true
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              color: white,
                              child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      topLeft: Radius.circular(20)),
                                  child: CustomWidget.rectangular(
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width,
                                  )),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: const Align(
                                  alignment: Alignment.center,
                                  child: CustomWidget.circular(
                                    height: 50,
                                    width: 50,
                                  )),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 5, 15, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: const [
                                      CustomWidget.circular(
                                        height: 20,
                                        width: 20,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      CustomWidget.circular(
                                        height: 20,
                                        width: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              SizedBox(
                                height: 3,
                              ),
                              CustomWidget.roundrectborder(
                                height: 20,
                                width: 150,
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              CustomWidget.roundrectborder(
                                height: 20,
                                width: 100,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        foregroundDecoration: BoxDecoration(
                          color: white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          gradient: LinearGradient(
                            colors: [
                              foryougradiantOne.withOpacity(0.2),
                              foryougradiantTwo.withOpacity(0.9),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [0.5, 2],
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: const CustomWidget.roundcorner(
                            height: 20,
                            width: 150,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: const Align(
                          alignment: Alignment.center,
                          child: CustomWidget.circular(
                            height: 50,
                            width: 50,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 15, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                CustomWidget.circular(
                                  height: 30,
                                  width: 30,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                CustomWidget.circular(
                                  height: 30,
                                  width: 30,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(bottom: 15, left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                CustomWidget.roundrectborder(
                                  height: 10,
                                  width: 100,
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                CustomWidget.roundrectborder(
                                  height: 10,
                                  width: 80,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
