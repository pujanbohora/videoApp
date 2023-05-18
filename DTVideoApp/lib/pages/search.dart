import 'dart:developer';

import 'package:dtvideo/pages/detailspage.dart';
import 'package:dtvideo/provider/apiprovider.dart';
import 'package:dtvideo/utils/color.dart';
import 'package:dtvideo/utils/customwidget.dart';
import 'package:dtvideo/widget/language.dart';
import 'package:dtvideo/widget/myimage.dart';
import 'package:dtvideo/widget/mynetworkimg.dart';
import 'package:dtvideo/widget/mytext.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => SearchState();
}

class SearchState extends State<Search> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final searchitem = Provider.of<ApiProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: primary,
        centerTitle: true,
        title: searchbar(),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: primary,
          child: Column(
            children: [
              browse(),
              popular(),
            ],
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
      margin: const EdgeInsets.fromLTRB(0, 6, 0, 0),
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
          borderRadius: const BorderRadius.all(
            Radius.circular(7),
          ),
        ),
        child: Row(children: [
          Flexible(
            flex: 1,
            child: InkWell(
              onTap: () {
                Navigator.pop(context, false);
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.center,
                child: MyImage(
                    imagePath: "assets/images/back.png", width: 17, height: 17),
              ),
            ),
          ),
          Flexible(
            flex: 9,
            child: TextField(
              textInputAction: TextInputAction.done,
              obscureText: false,
              controller: searchController,
              keyboardType: TextInputType.text,
              maxLines: 1,
              onChanged: (value) {
                if (searchController.text.length > 2) {
                  log('===> search api');
                  Provider.of<ApiProvider>(context, listen: false)
                      .search(searchController.text);
                }
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
        ]),
      ),
    );
  }

  Widget browse() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 250,
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Column(
        children: [
          Row(
            children: [
              LanguageText(
                  color: searchSmallText,
                  text: "browse",
                  maxline: 1,
                  fontsize: 14,
                  fontwaight: FontWeight.w500,
                  overflow: TextOverflow.ellipsis,
                  textalign: TextAlign.center,
                  fontstyle: FontStyle.normal),
              const Spacer(),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 210,
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 65,
                  child: Column(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Row(
                            children: [
                              MyImage(
                                  width: 35,
                                  height: 35,
                                  imagePath: "assets/images/ic_dance.png"),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText(
                                      color: white,
                                      text: "Dance",
                                      maxline: 1,
                                      fontsize: 12,
                                      fontwaight: FontWeight.w500,
                                      overflow: TextOverflow.ellipsis,
                                      textalign: TextAlign.center,
                                      fontstyle: FontStyle.normal),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  MyText(
                                      color: searchSmallText,
                                      text: "Solo,Kathak,Hip hop",
                                      maxline: 1,
                                      fontsize: 8,
                                      fontwaight: FontWeight.w500,
                                      overflow: TextOverflow.ellipsis,
                                      textalign: TextAlign.center,
                                      fontstyle: FontStyle.normal),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 1,
                        color: deviderLine,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 65,
                  child: Column(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Row(
                            children: [
                              MyImage(
                                  width: 35,
                                  height: 35,
                                  imagePath: "assets/images/ic_news.png"),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText(
                                      color: white,
                                      text: "News",
                                      maxline: 1,
                                      fontsize: 12,
                                      fontwaight: FontWeight.w500,
                                      overflow: TextOverflow.ellipsis,
                                      textalign: TextAlign.center,
                                      fontstyle: FontStyle.normal),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  MyText(
                                      color: searchSmallText,
                                      text: "City,World,Latest News",
                                      maxline: 1,
                                      fontsize: 8,
                                      fontwaight: FontWeight.w500,
                                      overflow: TextOverflow.ellipsis,
                                      textalign: TextAlign.center,
                                      fontstyle: FontStyle.normal),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 1,
                        color: deviderLine,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 65,
                  child: Column(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Row(
                            children: [
                              MyImage(
                                  width: 35,
                                  height: 35,
                                  imagePath: "assets/images/ic_geners.png"),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText(
                                      color: white,
                                      text: "Genres",
                                      maxline: 1,
                                      fontsize: 12,
                                      fontwaight: FontWeight.w500,
                                      overflow: TextOverflow.ellipsis,
                                      textalign: TextAlign.center,
                                      fontstyle: FontStyle.normal),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  MyText(
                                      color: searchSmallText,
                                      text: "Showa,Short Video,News",
                                      maxline: 1,
                                      fontsize: 8,
                                      fontwaight: FontWeight.w500,
                                      overflow: TextOverflow.ellipsis,
                                      textalign: TextAlign.center,
                                      fontstyle: FontStyle.normal),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 1,
                        color: deviderLine,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget popular() {
    return Consumer<ApiProvider>(builder: (context, searchProvider, child) {
      log("===> search ${searchProvider.loading}");
      if (!searchProvider.loading) {
        return searchshimer();
      } else {
        if (searchProvider.searchmodel.status == 200 &&
            (searchProvider.searchmodel.result?.length ?? 0) > 0) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Column(
              children: [
                Row(
                  children: [
                    LanguageText(
                        color: searchSmallText,
                        text: "popular",
                        maxline: 1,
                        fontsize: 14,
                        fontwaight: FontWeight.w500,
                        overflow: TextOverflow.ellipsis,
                        textalign: TextAlign.center,
                        fontstyle: FontStyle.normal),
                    const Spacer(),
                  ],
                ),
                Expanded(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      itemCount: searchProvider.searchmodel.result?.length ?? 0,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return DetailsPage(
                                    videoid: searchProvider
                                            .albumnmodel.result?[index].id
                                            .toString() ??
                                        "",
                                  );
                                },
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 100,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      alignment: Alignment.center,
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: MyNetworkImage(
                                                width: 70,
                                                height: 70,
                                                fit: BoxFit.cover,
                                                imagePath: searchProvider
                                                        .searchmodel
                                                        .result?[index]
                                                        .image
                                                        .toString() ??
                                                    "https://i.pinimg.com/564x/5d/69/42/5d6942c6dff12bd3f960eb30c5fdd0f9.jpg"),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          MyText(
                                              color: white,
                                              text: searchProvider.searchmodel
                                                      .result?[index].name
                                                      .toString() ??
                                                  "",
                                              maxline: 1,
                                              fontsize: 12,
                                              fontwaight: FontWeight.w500,
                                              overflow: TextOverflow.ellipsis,
                                              textalign: TextAlign.center,
                                              fontstyle: FontStyle.normal),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 1,
                                    color: deviderLine,
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
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.topCenter,
            child: LanguageText(
                color: white,
                text: "recordnotfound",
                fontsize: 16,
                fontwaight: FontWeight.w600,
                textalign: TextAlign.center,
                fontstyle: FontStyle.normal),
          );
        }
      }
    });
  }

  Widget searchshimer() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            alignment: Alignment.centerLeft,
            child: const CustomWidget.roundrectborder(
              height: 20,
              width: 100,
            ),
          ),
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: const CustomWidget.roundcorner(
                                      height: 70,
                                      width: 70,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  const CustomWidget.roundrectborder(
                                    height: 20,
                                    width: 200,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 1,
                            color: deviderLine,
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
  }
}
