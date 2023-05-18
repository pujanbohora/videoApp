import 'package:dtvideo/utils/color.dart';
import 'package:dtvideo/widget/language.dart';
import 'package:dtvideo/widget/myimage.dart';
import 'package:dtvideo/widget/mytext.dart';
import 'package:dtvideo/widget/mytextfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class Follow extends StatefulWidget {
  const Follow({Key? key}) : super(key: key);

  @override
  State<Follow> createState() => FollowState();
}

class FollowState extends State<Follow> with TickerProviderStateMixin {
  late TabController tabController =
      TabController(length: tabname.length, vsync: this);

  List<String> tabname = <String>[
    "Followers",
    "Following",
  ];

  List<String> followingImgList = <String>[
    "assets/images/pagersix.png",
    "assets/images/pagersix.png",
    "assets/images/pagersix.png",
    "assets/images/pagersix.png",
    "assets/images/pagersix.png",
    "assets/images/pagersix.png",
    "assets/images/pagersix.png",
    "assets/images/pagersix.png",
    "assets/images/pagersix.png",
    "assets/images/pagersix.png",
    "assets/images/pagersix.png",
    "assets/images/pagersix.png",
  ];

  List<String> followingUser = <String>[
    "Yash Patel",
    "Shah Udit",
    "Vraj Raval",
    "Priyank Patel",
    "Meet Patel",
    "Prit Patel",
    "Yash Patel",
    "Shah Udit",
    "Vraj Raval",
    "Priyank Patel",
    "Meet Patel",
    "Prit Patel",
  ];

  List<String> followingUsername = <String>[
    "yashpatel@341",
    "shahudit@456",
    "vrajraval@2121",
    "priyankpatel@563",
    "meetpatel@568",
    "pritpatel@894",
    "yashpatel@341",
    "shahudit@456",
    "vrajraval@2121",
    "priyankpatel@563",
    "meetpatel@568",
    "pritpatel@894",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: primary,
        centerTitle: false,
        title: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context, false);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 20,
                  height: 20,
                  child: MyImage(
                    width: 20,
                    height: 20,
                    imagePath: "assets/images/back.png",
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 0),
                child: MyText(
                    color: white,
                    maxline: 1,
                    overflow: TextOverflow.ellipsis,
                    text: "Bhoomi_123",
                    fontsize: 16,
                    fontwaight: FontWeight.w600,
                    textalign: TextAlign.center,
                    fontstyle: FontStyle.normal),
              ),
              const Spacer(),
              Container(
                width: 60,
                height: 20,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: requestBg,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: MyText(
                    color: white,
                    maxline: 1,
                    overflow: TextOverflow.ellipsis,
                    text: "2 Request",
                    fontsize: 8,
                    fontwaight: FontWeight.w600,
                    textalign: TextAlign.center,
                    fontstyle: FontStyle.normal),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: primary,
        child: Column(
          children: [
            tabViewTitle(),
            tabbarView(),
          ],
        ),
      ),
    );
  }

  Widget tabViewTitle() {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          alignment: Alignment.center,
          child: TabBar(
            indicatorColor: tabIndicater,
            indicatorSize: TabBarIndicatorSize.tab,
            isScrollable: true,
            indicatorWeight: 2,
            physics: const AlwaysScrollableScrollPhysics(),
            unselectedLabelColor: white,
            labelStyle: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal),
            labelColor: white,
            labelPadding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
            controller: tabController,
            tabs: List<Widget>.generate(tabname.length, (int index) {
              return Tab(
                child: SizedBox(
                  child: MyText(
                      color: white,
                      text: tabname[index],
                      fontsize: 14,
                      maxline: 1,
                      overflow: TextOverflow.ellipsis,
                      fontwaight: FontWeight.w600,
                      textalign: TextAlign.center,
                      fontstyle: FontStyle.normal),
                ),
              );
            }),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 1,
          color: deviderLine,
        ),
      ],
    );
  }

  Widget tabbarView() {
    return Expanded(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: TabBarView(
          controller: tabController,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  searchbarFollowers(),
                  followersList(),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  searchbarFollowing(),
                  followingList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchbarFollowers() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      color: primary,
      margin: const EdgeInsets.fromLTRB(0, 6, 0, 0),
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
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              child: Image.asset("assets/images/search.png",
                  width: 17, height: 17),
            ),
          ),
          Flexible(
            flex: 9,
            child: Center(
              child: MyTextField(
                hinttext: "Search",
                size: 14,
                color: white,
                textInputAction: TextInputAction.next,
                obscureText: false,
                keyboardType: TextInputType.text,
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget searchbarFollowing() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      color: primary,
      margin: const EdgeInsets.fromLTRB(0, 6, 0, 0),
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
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              child: Image.asset("assets/images/search.png",
                  width: 17, height: 17),
            ),
          ),
          Flexible(
            flex: 9,
            child: Center(
              child: MyTextField(
                hinttext: "Search",
                size: 14,
                color: white,
                textInputAction: TextInputAction.next,
                obscureText: false,
                keyboardType: TextInputType.text,
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget followersList() {
    return Flexible(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemCount: followingUser.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: primary,
                        border: const GradientBoxBorder(
                            width: 2,
                            gradient: LinearGradient(colors: [
                              followPagegradiantOne,
                              followPagegradiantTwo
                            ])),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: MyImage(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            fit: BoxFit.cover,
                            imagePath: followingImgList[index]),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                            color: white,
                            text: followingUser[index],
                            fontsize: 12,
                            maxline: 1,
                            overflow: TextOverflow.ellipsis,
                            fontwaight: FontWeight.w600,
                            textalign: TextAlign.center,
                            fontstyle: FontStyle.normal),
                        const SizedBox(
                          height: 5,
                        ),
                        MyText(
                            color: white,
                            text: followingUsername[index],
                            fontsize: 10,
                            maxline: 1,
                            overflow: TextOverflow.ellipsis,
                            fontwaight: FontWeight.w500,
                            textalign: TextAlign.center,
                            fontstyle: FontStyle.normal),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 50,
                      height: MediaQuery.of(context).size.height,
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      // color: white,
                      child: LanguageText(
                          color: follow,
                          text: "follow",
                          fontsize: 10,
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                          fontwaight: FontWeight.w500,
                          textalign: TextAlign.center,
                          fontstyle: FontStyle.normal),
                    ),
                    const Spacer(),
                    Container(
                      width: 80,
                      height: 25,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: removeBg,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: LanguageText(
                          color: white,
                          text: "remove",
                          fontsize: 10,
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                          fontwaight: FontWeight.w500,
                          textalign: TextAlign.center,
                          fontstyle: FontStyle.normal),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget followingList() {
    return Flexible(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemCount: followingUser.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: primary,
                        border: const GradientBoxBorder(
                            width: 2,
                            gradient: LinearGradient(colors: [
                              followPagegradiantOne,
                              followPagegradiantTwo
                            ])),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: MyImage(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            fit: BoxFit.cover,
                            imagePath: followingImgList[index]),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                            color: white,
                            text: followingUser[index],
                            fontsize: 12,
                            maxline: 1,
                            overflow: TextOverflow.ellipsis,
                            fontwaight: FontWeight.w600,
                            textalign: TextAlign.center,
                            fontstyle: FontStyle.normal),
                        const SizedBox(
                          height: 5,
                        ),
                        MyText(
                            color: white,
                            text: followingUsername[index],
                            fontsize: 10,
                            maxline: 1,
                            overflow: TextOverflow.ellipsis,
                            fontwaight: FontWeight.w500,
                            textalign: TextAlign.center,
                            fontstyle: FontStyle.normal),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      width: 80,
                      height: 25,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: removeBg,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: LanguageText(
                          color: white,
                          text: "remove",
                          fontsize: 10,
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                          fontwaight: FontWeight.w500,
                          textalign: TextAlign.center,
                          fontstyle: FontStyle.normal),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
