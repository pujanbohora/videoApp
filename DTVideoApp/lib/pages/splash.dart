import 'dart:developer';

import 'package:dtvideo/pages/bottonnavigation.dart';
import 'package:dtvideo/pages/intro.dart';
import 'package:dtvideo/provider/apiprovider.dart';
import 'package:dtvideo/utils/sharedpre.dart';
import 'package:dtvideo/widget/myimage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/adhelper.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => SplashState();
}

class SplashState extends State<Splash> {
  String? seen;
  late int index;
  SharedPre sharedPre = SharedPre();

  // ignore: prefer_typing_uninitialized_variables
  @override
  initState() {
    final bannerdata = Provider.of<ApiProvider>(context, listen: false);
    bannerdata.getGeneralsetting();

    FirebaseMessaging.instance.getToken().then((value) {
      String? token = value;
      log("===> Token $token");
    });

    AdHelper.getAds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    idFirstChack();

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        child: MyImage(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fill,
            imagePath: "assets/images/splashBg.png"),
      ),
    );
  }

  Future<void> idFirstChack() async {
    final bannerdata = Provider.of<ApiProvider>(context);
    if (bannerdata.loading) {
      for (var i = 0; i < bannerdata.generalsettingmodel.result!.length; i++) {
        SharedPre().save(
            bannerdata.generalsettingmodel.result![i].key.toString(),
            bannerdata.generalsettingmodel.result![i].value.toString());
      }
      seen = await sharedPre.read('seen');
      if (seen.toString() == "1") {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const BottomNavigation();
            },
          ),
        );
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const Intro();
            },
          ),
        );
      }
    }
  }
}
