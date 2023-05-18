import 'package:dtvideo/pages/detailspage.dart';
import 'package:dtvideo/pages/nodata.dart';
import 'package:dtvideo/provider/apiprovider.dart';
import 'package:dtvideo/utils/color.dart';
import 'package:dtvideo/utils/customwidget.dart';
import 'package:dtvideo/utils/sharedpre.dart';
import 'package:dtvideo/utils/utils.dart';
import 'package:dtvideo/widget/language.dart';
import 'package:dtvideo/widget/myimage.dart';
import 'package:dtvideo/widget/mynetworkimg.dart';
import 'package:dtvideo/widget/mytext.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:provider/provider.dart';

class Favouritevideo extends StatefulWidget {
  const Favouritevideo({Key? key}) : super(key: key);

  @override
  State<Favouritevideo> createState() => FavouritevideoState();
}

class FavouritevideoState extends State<Favouritevideo> {
  SharedPre sharePref = SharedPre();
  var userid = "";
  // String userid = "3";

  @override
  void initState() {
    getUserID();
    super.initState();
  }

  getUserID() async {
    userid = await sharePref.read("userid") ?? "";
    // ignore: use_build_context_synchronously
    final favouritevideoitem = Provider.of<ApiProvider>(context, listen: false);
    // ignore: use_build_context_synchronously
    favouritevideoitem.favouritelist(userid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      fontsize: 16,
                      fontwaight: FontWeight.w600,
                      maxline: 1,
                      text: "favouritevideos",
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
        child: Column(
          children: [
            favoutiteVideo(),
          ],
        ),
      ),
    );
  }

  Widget favoutiteVideo() {
    return Consumer<ApiProvider>(
        builder: (context, favouritevideoprovider, child) {
      if (!favouritevideoprovider.loading) {
        return favouriteVideoshimmer();
      } else {
        if (favouritevideoprovider.favouritelistmodel.status == 200 &&
            (favouritevideoprovider.favouritelistmodel.result?.length ?? 0) >
                0) {
          return Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: primary,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemCount:
                  favouritevideoprovider.favouritelistmodel.result?.length ?? 0,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailsPage(
                                videoid: favouritevideoprovider
                                        .favouritelistmodel.result?[index].id ??
                                    "",
                                catid: favouritevideoprovider.favouritelistmodel
                                        .result?[index].categoryId ??
                                    "",
                              )),
                    );
                  },
                  child: SizedBox(
                    height: 180,
                    child: Stack(
                      children: [
                        Align(
                          alignment: AlignmentDirectional.center,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              decoration: BoxDecoration(
                                border: const GradientBoxBorder(
                                  width: 4,
                                  gradient: LinearGradient(
                                    colors: [
                                      borderFav,
                                      favouritegradiantBorderTwo,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    stops: [0, 2],
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              // foregroundDecoration: BoxDecoration(
                              //   gradient: LinearGradient(
                              //     colors: [
                              //       foryougradiantOne.withOpacity(0.1),
                              //       foryougradiantTwo.withOpacity(0.8),
                              //     ],
                              //     begin: Alignment.topCenter,
                              //     end: Alignment.bottomCenter,
                              //     stops: const [0.4, 3],
                              //   ),
                              // ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: MyNetworkImage(
                                  imagePath: favouritevideoprovider
                                          .favouritelistmodel
                                          .result?[index]
                                          .image
                                          .toString() ??
                                      "https://i.pinimg.com/564x/5d/69/42/5d6942c6dff12bd3f960eb30c5fdd0f9.jpg",
                                  fit: BoxFit.fill,
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: MyImage(
                              width: 40,
                              height: 40,
                              imagePath: "assets/images/play.png"),
                        ),
                        Positioned(
                          bottom: 5,
                          child: Center(
                            child: SizedBox(
                              width: 160,
                              child: MyText(
                                  color: white,
                                  text: favouritevideoprovider
                                          .favouritelistmodel
                                          .result?[index]
                                          .name
                                          .toString() ??
                                      "",
                                  fontsize: 12,
                                  fontwaight: FontWeight.w500,
                                  maxline: 2,
                                  textalign: TextAlign.center,
                                  fontstyle: FontStyle.normal),
                            ),
                          ),
                        ),
                        Positioned(
                            right: 10,
                            top: 10,
                            child: InkWell(
                              onTap: () async {
                                await favouritevideoprovider.addfavourite(
                                    favouritevideoprovider
                                        .favouritelistmodel.result?[index].id
                                        .toString(),
                                    userid);
                                if (favouritevideoprovider.loading) {
                                  Utils().showToast(favouritevideoprovider
                                      .addfavouritemodel.message
                                      .toString());

                                  favouritevideoprovider.favouritelist(userid);
                                }
                              },
                              child: Image.asset(
                                "assets/images/ic_delete.png",
                                width: 30,
                                height: 30,
                              ),
                            ))
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return const NoData();
        }
      }
    });
  }

  Widget favouriteVideoshimmer() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 700,
      color: primary,
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: List.generate(10, (index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
            child: Column(children: const [
              CustomWidget.roundcorner(
                width: 180,
                height: 160,
              )
            ]),
          );
        }),
      ),
    );
  }
}
