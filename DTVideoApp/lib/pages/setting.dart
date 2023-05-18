import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:dtvideo/pages/download.dart';
import 'package:dtvideo/pages/editprofile.dart';
import 'package:dtvideo/pages/login.dart';
import 'package:dtvideo/provider/apiprovider.dart';
import 'package:dtvideo/subscription/subscription.dart';
import 'package:dtvideo/utils/color.dart';
import 'package:dtvideo/utils/customwidget.dart';
import 'package:dtvideo/utils/sharedpre.dart';
import 'package:dtvideo/utils/utils.dart';
import 'package:dtvideo/widget/language.dart';
import 'package:dtvideo/widget/myimage.dart';
import 'package:dtvideo/widget/mynetworkimg.dart';
import 'package:dtvideo/widget/mytext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slidable_button/slidable_button.dart';

import 'favouritevideo.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => SettingState();
}

class SettingState extends State<Setting> {
  SharedPre sharePref = SharedPre();
  String? userid, push;
  InterstitialAd? _interstitialAd;

  @override
  void initState() {
    super.initState();
    getuserId();
  }

  getuserId() async {
    userid = await sharePref.read("userid") ?? "";
    push = await sharePref.read("pushn") ?? "";
    log("===>$push");
    setState(() {});

    if (userid!.isNotEmpty || userid != "") {
      debugPrint("user ID $userid");
      // ignore: use_build_context_synchronously
      final profileitem = Provider.of<ApiProvider>(context, listen: false);
      await profileitem.getUserId();
      await profileitem.profile();

      if (profileitem.loading) {
        log("===>loading ${profileitem.loading}");
        await sharePref.save(
            "is_buy", profileitem.profilemodel.result![0].isbuy.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: settingpage(),
      ),
    );
  }

  Widget settingpage() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: primary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<ApiProvider>(
            builder: (context, profileprovider, child) {
              if (!profileprovider.loading) {
                return const CircularProgressIndicator();
              } else {
                return Flexible(
                  flex: 1,
                  child: Stack(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          alignment: Alignment.bottomCenter,
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
                          child: MyImage(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              fit: BoxFit.cover,
                              imagePath: "assets/images/editprofile.png")),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Stack(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  DottedBorder(
                                    dashPattern: const [5, 5],
                                    borderType: BorderType.RRect,
                                    color: botborder,
                                    radius: const Radius.circular(40),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(40),
                                        child: (profileprovider
                                                        .profilemodel.status ==
                                                    200 &&
                                                ((profileprovider
                                                            .profilemodel
                                                            .result?[0]
                                                            .image
                                                            ?.length ??
                                                        0) !=
                                                    0))
                                            ? MyNetworkImage(
                                                width: 100,
                                                height: 100,
                                                imagePath: (profileprovider
                                                        .profilemodel
                                                        .result?[0]
                                                        .image
                                                        .toString() ??
                                                    "https://i.pinimg.com/564x/5d/69/42/5d6942c6dff12bd3f960eb30c5fdd0f9.jpg"),
                                                fit: BoxFit.fill,
                                              )
                                            : MyImage(
                                                width: 100,
                                                height: 100,
                                                imagePath:
                                                    "assets/images/ic_user.png"),
                                      ),
                                    ),
                                  ),
                                  MyText(
                                      color: white,
                                      text: (profileprovider
                                                      .profilemodel.status ==
                                                  200 &&
                                              (profileprovider.profilemodel
                                                          .result?[0].fullname
                                                          .toString() ??
                                                      "")
                                                  .isEmpty)
                                          ? (profileprovider
                                                  .profilemodel.result?[0].email
                                                  .toString() ??
                                              "Guest User")
                                          : profileprovider
                                                      .profilemodel.status ==
                                                  200
                                              ? (profileprovider.profilemodel
                                                      .result?[0].fullname
                                                      .toString() ??
                                                  "Guest User")
                                              : "",
                                      fontsize: 16,
                                      maxline: 1,
                                      overflow: TextOverflow.ellipsis,
                                      fontwaight: FontWeight.w600,
                                      textalign: TextAlign.center,
                                      fontstyle: FontStyle.normal),
                                  MyText(
                                      color: white,
                                      text:
                                          profileprovider.profilemodel.status ==
                                                  200
                                              ? (profileprovider.profilemodel
                                                      .result?[0].mobile
                                                      .toString() ??
                                                  "Guest User")
                                              : "Guest User",
                                      fontsize: 16,
                                      maxline: 1,
                                      overflow: TextOverflow.ellipsis,
                                      fontwaight: FontWeight.w600,
                                      textalign: TextAlign.center,
                                      fontstyle: FontStyle.normal)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30, left: 5),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                              iconSize: 15,
                              onPressed: () {},
                              icon: MyImage(
                                  width: 20,
                                  height: 20,
                                  imagePath: "assets/images/menu.png")),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50, right: 20),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () {
                              log("userID Setting $userid");
                              if (userid!.isEmpty) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Login(),
                                  ),
                                );
                              } else {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => Editprofile(
                                //       imagepath: profileprovider
                                //               .profilemodel.result?[0].image
                                //               .toString() ??
                                //           "",
                                //       fullname: profileprovider
                                //               .profilemodel.result?[0].fullname
                                //               .toString() ??
                                //           "",
                                //     ),
                                //   ),
                                // );

                                Navigator.of(context)
                                    .push(
                                  MaterialPageRoute(
                                      builder: (_) => Editprofile(
                                            imagepath: profileprovider
                                                    .profilemodel
                                                    .result?[0]
                                                    .image
                                                    .toString() ??
                                                "",
                                            fullname: profileprovider
                                                    .profilemodel
                                                    .result?[0]
                                                    .fullname
                                                    .toString() ??
                                                "",
                                          )),
                                )
                                    .then((val) async {
                                  final profileitem = Provider.of<ApiProvider>(
                                      context,
                                      listen: false);
                                  await profileitem.getUserId();
                                  await profileitem.profile();

                                  if (profileitem.loading) {
                                    log("===>loading ${profileitem.loading}");
                                    await sharePref.save(
                                        "is_buy",
                                        profileitem
                                            .profilemodel.result![0].isbuy
                                            .toString());
                                  }
                                });
                              }
                            },
                            child: userid != ""
                                ? MyImage(
                                    width: 25,
                                    height: 25,
                                    imagePath: "assets/images/edit.png")
                                : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
          Flexible(
            flex: 2,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        HorizontalSlidableButton(
                          width: 320,
                          height: 50,
                          buttonWidth: 160,
                          color: swipebg,
                          buttonColor: pushnotificationBg,
                          dismissible: false,
                          initialPosition: push == "0"
                              ? SlidableButtonPosition.end
                              : SlidableButtonPosition.start,
                          label: Center(
                              child: LanguageText(
                                  color: white,
                                  text: "pushnotification",
                                  fontsize: 12,
                                  fontwaight: FontWeight.w600,
                                  textalign: TextAlign.center,
                                  fontstyle: FontStyle.normal)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 40, 0),
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: MyImage(
                                    width: 20,
                                    height: 20,
                                    imagePath: "assets/images/rightArrow.png")),
                          ),
                          onChanged: (position) async {
                            if (position == SlidableButtonPosition.end) {
                              Utils().showToast("PushNotification On");
                              log("==>0");
                              await sharePref.save("pushn", "0");
                              setState(() {});
                            } else {
                              Utils().showToast("PushNotification Off");
                              log("==>1");
                              await sharePref.save("pushn", "1");
                              setState(() {});
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Favouritevideo()));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      // color: white,
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          if (userid!.isNotEmpty || userid != "") {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const Favouritevideo()));
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()),
                            );
                          }
                        },
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            MyImage(
                                width: 35,
                                height: 35,
                                imagePath: "assets/images/myfavourite.png"),
                            const SizedBox(
                              width: 20,
                            ),
                            LanguageText(
                                color: white,
                                text: "myfavourite",
                                fontsize: 14,
                                fontwaight: FontWeight.w500,
                                textalign: TextAlign.center,
                                fontstyle: FontStyle.normal),
                            const Spacer(),
                            Padding(
                                padding:
                                    const EdgeInsets.only(right: 20, left: 20),
                                child: MyImage(
                                    width: 20,
                                    height: 20,
                                    imagePath: "assets/images/rightArrow.png")),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _onShare(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          MyImage(
                              width: 35,
                              height: 35,
                              imagePath: "assets/images/sharefriend.png"),
                          const SizedBox(
                            width: 20,
                          ),
                          LanguageText(
                              color: white,
                              text: "sharefriend",
                              fontsize: 14,
                              fontwaight: FontWeight.w500,
                              textalign: TextAlign.center,
                              fontstyle: FontStyle.normal),
                          const Spacer(),
                          Padding(
                              padding:
                                  const EdgeInsets.only(right: 20, left: 20),
                              child: MyImage(
                                  width: 20,
                                  height: 20,
                                  imagePath: "assets/images/rightArrow.png")),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (userid!.isNotEmpty || userid != "") {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Subscription()));
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()),
                        );
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          MyImage(
                              width: 35,
                              height: 35,
                              imagePath: "assets/images/ic_sub.png"),
                          const SizedBox(
                            width: 20,
                          ),
                          LanguageText(
                              color: white,
                              text: "subscription",
                              fontsize: 14,
                              fontwaight: FontWeight.w500,
                              textalign: TextAlign.center,
                              fontstyle: FontStyle.normal),
                          const Spacer(),
                          Padding(
                              padding:
                                  const EdgeInsets.only(right: 20, left: 20),
                              child: MyImage(
                                  width: 20,
                                  height: 20,
                                  imagePath: "assets/images/rightArrow.png")),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        backgroundColor: white,
                        builder: (BuildContext context) {
                          return BottomSheet(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            onClosing: () {},
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                builder: (BuildContext context, state) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 200,
                                    color: white,
                                    child: Column(
                                      children: [
                                        ListTile(
                                          title: const Text("English"),
                                          onTap: () {
                                            state(() {});
                                            LocaleNotifier.of(context)
                                                ?.change('en');
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        ListTile(
                                          title: const Text("Arabic"),
                                          onTap: () {
                                            state(() {});
                                            LocaleNotifier.of(context)
                                                ?.change('ar');
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        ListTile(
                                          title: const Text("Hindi"),
                                          onTap: () {
                                            state(() {});
                                            LocaleNotifier.of(context)
                                                ?.change('hi');
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                color: pushnotificationBg,
                                borderRadius: BorderRadius.circular(5)),
                            alignment: Alignment.center,
                            child: MyImage(
                                width: 20,
                                height: 20,
                                imagePath: "assets/images/ic_lan.png",
                                color: white),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          LanguageText(
                              color: white,
                              text: "laguage",
                              fontsize: 14,
                              fontwaight: FontWeight.w500,
                              textalign: TextAlign.center,
                              fontstyle: FontStyle.normal),
                          const Spacer(),
                          Padding(
                              padding:
                                  const EdgeInsets.only(right: 20, left: 20),
                              child: MyImage(
                                  width: 20,
                                  height: 20,
                                  imagePath: "assets/images/rightArrow.png")),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      // ignore: unnecessary_null_comparison
                      if (userid!.isEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 0,
                              insetPadding: const EdgeInsets.all(15),
                              backgroundColor: addcommentPopup,
                              child: Container(
                                width: 300,
                                height: 150,
                                decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 60,
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 0, 0),
                                      child: MyText(
                                          color: primary,
                                          text: "Are you Sure??",
                                          fontsize: 18,
                                          maxline: 1,
                                          fontwaight: FontWeight.w600,
                                          overflow: TextOverflow.ellipsis,
                                          textalign: TextAlign.center,
                                          fontstyle: FontStyle.normal),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 90,
                                      alignment: Alignment.center,
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const Login()),
                                                      (Route<dynamic> route) =>
                                                          false);
                                              clearStorage();
                                              Utils().showToast(
                                                  "Logout Successfully");
                                            },
                                            child: Container(
                                              width: 120,
                                              height: 45,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: primary,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              child: MyText(
                                                  color: white,
                                                  text: "Logout",
                                                  fontsize: 14,
                                                  maxline: 1,
                                                  fontwaight: FontWeight.w600,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textalign: TextAlign.center,
                                                  fontstyle: FontStyle.normal),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                              _interstitialAd?.show();
                                            },
                                            child: Container(
                                              width: 120,
                                              height: 45,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  // color: primary,
                                                  border: Border.all(
                                                      color: primary, width: 2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              child: MyText(
                                                  color: primary,
                                                  text: "Cancle",
                                                  fontsize: 14,
                                                  maxline: 1,
                                                  fontwaight: FontWeight.w600,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textalign: TextAlign.center,
                                                  fontstyle: FontStyle.normal),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          MyImage(
                              width: 35,
                              height: 35,
                              imagePath: "assets/images/login.png"),
                          const SizedBox(
                            width: 20,
                          ),
                          LanguageText(
                              color: white,
                              text: (userid == "" || userid == null)
                                  ? "login"
                                  : "logout",
                              fontsize: 14,
                              fontwaight: FontWeight.w500,
                              textalign: TextAlign.center,
                              fontstyle: FontStyle.normal),
                          const Spacer(),
                          Padding(
                              padding:
                                  const EdgeInsets.only(right: 20, left: 20),
                              child: MyImage(
                                  width: 20,
                                  height: 20,
                                  imagePath: "assets/images/rightArrow.png")),
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
    );
  }

  Widget settingshimmer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          flex: 1,
          child: Stack(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  alignment: Alignment.bottomCenter,
                  foregroundDecoration: BoxDecoration(
                    color: white,
                    borderRadius: const BorderRadius.all(Radius.circular(24)),
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
                    width: MediaQuery.of(context).size.height,
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 90),
                child: Align(
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          DottedBorder(
                            dashPattern: const [5, 5],
                            borderType: BorderType.RRect,
                            color: botborder,
                            radius: const Radius.circular(40),
                            child: Padding(
                              padding: const EdgeInsets.all(3),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: const CustomWidget.rectangular(
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const CustomWidget.roundcorner(
                            height: 10,
                            width: 100,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 30, left: 5),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: CustomWidget.rectangular(
                    height: 20,
                    width: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50, right: 20),
                child: Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {},
                    child: const CustomWidget.rectangular(
                      height: 25,
                      width: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Flexible(
          flex: 2,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      CustomWidget.roundcorner(
                        height: 50,
                        width: 100,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  alignment: Alignment.center,
                  child: Row(
                    children: const [
                      SizedBox(
                        width: 20,
                      ),
                      CustomWidget.rectangular(
                        height: 35,
                        width: 35,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      CustomWidget.roundcorner(
                        height: 35,
                        width: 100,
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: CustomWidget.rectangular(
                          height: 35,
                          width: 35,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  alignment: Alignment.center,
                  child: Row(
                    children: const [
                      SizedBox(
                        width: 20,
                      ),
                      CustomWidget.rectangular(
                        height: 35,
                        width: 35,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      CustomWidget.roundcorner(
                        height: 35,
                        width: 100,
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: CustomWidget.rectangular(
                          height: 35,
                          width: 35,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  alignment: Alignment.center,
                  child: Row(
                    children: const [
                      SizedBox(
                        width: 20,
                      ),
                      CustomWidget.rectangular(
                        height: 35,
                        width: 35,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      CustomWidget.roundcorner(
                        height: 35,
                        width: 100,
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: CustomWidget.rectangular(
                          height: 35,
                          width: 35,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Downloadpage()),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    alignment: Alignment.center,
                    child: Row(
                      children: const [
                        SizedBox(
                          width: 20,
                        ),
                        CustomWidget.rectangular(
                          height: 35,
                          width: 35,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        CustomWidget.roundcorner(
                          height: 35,
                          width: 100,
                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: CustomWidget.rectangular(
                            height: 35,
                            width: 35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    alignment: Alignment.center,
                    child: Row(
                      children: const [
                        SizedBox(
                          width: 20,
                        ),
                        CustomWidget.rectangular(
                          height: 35,
                          width: 35,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        CustomWidget.roundcorner(
                          height: 35,
                          width: 100,
                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: CustomWidget.rectangular(
                            height: 35,
                            width: 35,
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
    );
  }

  void _onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share("text",
        subject: "subject",
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }

  clearStorage() async {
    SharedPreferences prefManager = await SharedPreferences.getInstance();
    await prefManager.clear();
  }
}
