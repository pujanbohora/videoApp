import 'dart:developer';

import 'package:dtvideo/pages/nodata.dart';
import 'package:dtvideo/provider/apiprovider.dart';
import 'package:dtvideo/utils/color.dart';
import 'package:dtvideo/utils/sharedpre.dart';
import 'package:dtvideo/widget/myimage.dart';
import 'package:dtvideo/widget/mytext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Pushnotification extends StatefulWidget {
  const Pushnotification({Key? key}) : super(key: key);

  @override
  State<Pushnotification> createState() => PushnotificationState();
}

class PushnotificationState extends State<Pushnotification> {
  SharedPre sharePref = SharedPre();
  String? userid;

  @override
  void initState() {
    super.initState();
    getuserId();
  }

  getuserId() async {
    userid = await sharePref.read("userid") ?? "";

    if (userid!.isNotEmpty || userid != "") {
      debugPrint("user ID $userid");
      // ignore: use_build_context_synchronously
      final notificationProvider =
          Provider.of<ApiProvider>(context, listen: false);
      await notificationProvider.getUserId();
      await notificationProvider.getnotification(userid!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context, false);
              },
              child: Container(
                width: 80,
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.centerLeft,
                child: MyImage(
                    width: 20, height: 20, imagePath: "assets/images/back.png"),
              ),
            ),
            Container(
              width: 120,
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              child: MyText(
                  color: white,
                  text: "Notification",
                  fontsize: 16,
                  fontwaight: FontWeight.w500,
                  textalign: TextAlign.center,
                  fontstyle: FontStyle.normal),
            ),
            Container(
              width: 80,
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Consumer<ApiProvider>(
                    builder: (context, notificationdataProvider, child) {
                      if (notificationdataProvider.loading) {
                        return MyText(
                            color: white,
                            text: (notificationdataProvider
                                        .notificationModel.result?.length ??
                                    0)
                                .toString(),
                            fontsize: 10,
                            fontwaight: FontWeight.w500,
                            textalign: TextAlign.center,
                            fontstyle: FontStyle.normal);
                      } else {
                        return MyText(
                            color: white,
                            text: "0",
                            fontsize: 10,
                            fontwaight: FontWeight.w500,
                            textalign: TextAlign.center,
                            fontstyle: FontStyle.normal);
                      }
                    },
                  ),
                  const SizedBox(width: 3),
                  MyText(
                      color: white,
                      text: "inbox",
                      fontsize: 10,
                      fontwaight: FontWeight.w500,
                      textalign: TextAlign.center,
                      fontstyle: FontStyle.normal),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: notification(),
      ),
    );
  }

  Widget notification() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: primary,
      child: Consumer<ApiProvider>(
        builder: (context, notificationDataProvider, child) {
          if (!notificationDataProvider.loading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (notificationDataProvider.notificationModel.status == 200 &&
                (notificationDataProvider.notificationModel.result?.length ??
                        0) >
                    0) {
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount:
                      notificationDataProvider.notificationModel.result?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 65,
                        color: primary,
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: MediaQuery.of(context).size.height,
                              alignment: Alignment.topCenter,
                              child: MyImage(
                                  width: 20,
                                  height: 20,
                                  imagePath: "assets/images/notification.png"),
                            ),
                            Expanded(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 20,
                                      alignment: Alignment.topLeft,
                                      child: Row(
                                        children: [
                                          MyText(
                                              color: white,
                                              text: "DT Videos",
                                              fontsize: 10,
                                              fontwaight: FontWeight.w500,
                                              textalign: TextAlign.center,
                                              fontstyle: FontStyle.normal),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          MyText(
                                              color: white,
                                              text: "09:45 AM",
                                              fontsize: 10,
                                              fontwaight: FontWeight.w500,
                                              textalign: TextAlign.center,
                                              fontstyle: FontStyle.normal),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: MyText(
                                              color: white,
                                              text: notificationDataProvider
                                                  .notificationModel
                                                  .result?[index]
                                                  .data
                                                  .toString(),
                                              fontsize: 10,
                                              overflow: TextOverflow.ellipsis,
                                              maxline: 3,
                                              fontwaight: FontWeight.w500,
                                              textalign: TextAlign.left,
                                              fontstyle: FontStyle.normal),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 70,
                              height: MediaQuery.of(context).size.height,
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      margin: const EdgeInsets.only(right: 15),
                                      alignment: Alignment.topRight,
                                      child: InkWell(
                                          onTap: () async {
                                            debugPrint("Index :$index");
                                            //Remove
                                            await notificationDataProvider
                                                .readnotification(
                                                    userid!,
                                                    notificationDataProvider
                                                            .notificationModel
                                                            .result?[index]
                                                            .id
                                                            .toString() ??
                                                        "");
                                            if (notificationDataProvider
                                                .loading) {
                                              await notificationDataProvider
                                                  .getnotification(userid!);
                                            }
                                          },
                                          child: Container(
                                              width: 25,
                                              height: 25,
                                              color: delete,
                                              padding: const EdgeInsets.all(3),
                                              child: MyImage(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: MediaQuery.of(context)
                                                      .size
                                                      .height,
                                                  imagePath:
                                                      "assets/images/delete.png"))),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 20,
                                    alignment: Alignment.bottomLeft,
                                    margin: const EdgeInsets.only(left: 5),
                                    child: MyText(
                                      text: "2 Days Ago",
                                      fontsize: 8,
                                      fontwaight: FontWeight.w500,
                                      textalign: TextAlign.center,
                                      fontstyle: FontStyle.normal,
                                      color: white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return const NoData();
            }
          }
        },
      ),
    );
  }
}
