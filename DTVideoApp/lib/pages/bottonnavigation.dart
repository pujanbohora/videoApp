import 'dart:io';

import 'package:dtvideo/pages/category.dart';
import 'package:dtvideo/pages/explore.dart';
import 'package:dtvideo/pages/home.dart';
import 'package:dtvideo/pages/setting.dart';
import 'package:dtvideo/utils/color.dart';
import 'package:dtvideo/utils/sharedpre.dart';
import 'package:dtvideo/widget/myimage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../utils/adhelper.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigation> {
  SharedPre sharePref = SharedPre();
  int selectedIndex = 0;
  var androidBannerAdsId = "";
  var iosBannerAdsId = "";
  var bannerad = "";
  var banneradIos = "";

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> widgetOptions = <Widget>[
    const Home(),
    const Categorypage(),
    const Explore(),
    const Setting(),
  ];

  @override
  void initState() {
    super.initState();
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

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (bannerad == "yes" || banneradIos == "yes")
            SizedBox(
              height: 60,
              child: AdWidget(
                  ad: AdHelper.createBannerAd()..load(), key: UniqueKey()),
            ),
          SizedBox(
            height: Platform.isIOS ? 85 : 60,
            child: BottomNavigationBar(
              backgroundColor: navigationBg,
              selectedLabelStyle: GoogleFonts.inter(
                fontSize: 10,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600,
                color: primary,
              ),
              unselectedLabelStyle: GoogleFonts.inter(
                fontSize: 10,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600,
                color: primary,
              ),
              selectedFontSize: 12,
              unselectedFontSize: 12,
              selectedIconTheme: const IconThemeData(color: primary),
              unselectedIconTheme: const IconThemeData(color: loginbgLight),
              elevation: 0,
              currentIndex: selectedIndex,
              selectedItemColor: loginbgLight,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  backgroundColor: navigationBg,
                  label: "",
                  activeIcon: Image.asset(
                    "assets/images/home.png",
                    width: 25,
                    height: 25,
                    color: loginbgLight,
                  ),
                  icon: Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/home.png",
                      width: 25,
                      height: 25,
                      color: white,
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  label: "",
                  backgroundColor: navigationBg,
                  activeIcon: Image.asset(
                    "assets/images/category.png",
                    width: 25,
                    height: 25,
                    color: loginbgLight,
                    fit: BoxFit.fill,
                  ),
                  icon: Align(
                    alignment: Alignment.center,
                    child: MyImage(
                      width: 25,
                      fit: BoxFit.fill,
                      height: 25,
                      imagePath: "assets/images/category.png",
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  backgroundColor: navigationBg,
                  label: "",
                  activeIcon: Image.asset(
                    "assets/images/explore.png",
                    width: 25,
                    height: 25,
                    color: loginbgLight,
                  ),
                  icon: Align(
                    alignment: Alignment.center,
                    child: MyImage(
                      width: 25,
                      height: 25,
                      imagePath: "assets/images/explore.png",
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  backgroundColor: white,
                  label: "",
                  activeIcon: Image.asset(
                    "assets/images/setting.png",
                    color: loginbgLight,
                    width: 25,
                    height: 25,
                  ),
                  icon: Align(
                    alignment: Alignment.center,
                    child: MyImage(
                      width: 25,
                      height: 25,
                      imagePath: "assets/images/setting.png",
                    ),
                  ),
                ),
              ],
              onTap: _onItemTapped,
            ),
          ),
        ],
      ),
    );
  }
}
