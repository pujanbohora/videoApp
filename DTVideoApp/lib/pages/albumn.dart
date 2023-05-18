import 'package:dtvideo/utils/color.dart';
import 'package:dtvideo/utils/sharedpre.dart';
import 'package:dtvideo/widget/language.dart';
import 'package:dtvideo/widget/myimage.dart';
import 'package:dtvideo/widget/mynetworkimg.dart';
import 'package:dtvideo/widget/mytext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../provider/apiprovider.dart';
import 'detailspage.dart';

class Albumn extends StatefulWidget {
  const Albumn({Key? key}) : super(key: key);

  @override
  State<Albumn> createState() => AlbumnState();
}

class AlbumnState extends State<Albumn> {
  SharedPre sharePref = SharedPre();
  String userid = "";

  getuserid() async {
    userid = await sharePref.read("userid") ?? "";
    debugPrint("UserID:$userid");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: primary,
        title: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    debugPrint("Click");
                    Navigator.pop(context, false);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: MyImage(
                      width: 20,
                      height: 20,
                      imagePath: "assets/images/back.png",
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 10,
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: LanguageText(
                      color: white,
                      fontsize: 14,
                      fontwaight: FontWeight.w600,
                      maxline: 1,
                      text: "albums",
                      textalign: TextAlign.center,
                      fontstyle: FontStyle.normal),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: primary,
          child: Column(
            children: [
              albumn(),
            ],
          ),
        ),
      ),
    );
  }

  Widget albumn() {
    return Consumer<ApiProvider>(builder: (context, albumnprovider, child) {
      return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.fromLTRB(15, 0, 15, 5),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
                childAspectRatio: 3 / 3.2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemCount: albumnprovider.albumnmodel.result?.length ?? 0,
            itemBuilder: (context, index) {
              final DateTime now = DateTime.parse(albumnprovider
                      .albumnmodel.result?[index].createdAt
                      .toString() ??
                  "");
              final DateFormat formatter = DateFormat('MMM d yyyy');
              final String formatted = formatter.format(now);

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return DetailsPage(
                          videoid: albumnprovider.albumnmodel.result?[index].id
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
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              gradient: LinearGradient(
                                colors: [
                                  danceclassisgradiantOne.withOpacity(0.2),
                                  danceclassisgradiantTwo.withOpacity(0.8),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: const [0.5, 2],
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: MyNetworkImage(
                                imagePath: albumnprovider
                                        .albumnmodel.result?[index].image
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
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 5, left: 3),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText(
                                      color: white,
                                      fontsize: 12,
                                      fontwaight: FontWeight.w600,
                                      text: albumnprovider
                                              .albumnmodel.result?[index].name
                                              .toString() ??
                                          "",
                                      textalign: TextAlign.center,
                                      fontstyle: FontStyle.normal),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  MyText(
                                      color: danceclassesTextYellow,
                                      fontsize: 10,
                                      fontwaight: FontWeight.w400,
                                      text: formatted,
                                      textalign: TextAlign.center,
                                      fontstyle: FontStyle.normal),
                                ],
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
          ));
    });
  }
}
