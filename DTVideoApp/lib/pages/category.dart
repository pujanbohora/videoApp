import 'package:dtvideo/pages/nodata.dart';
import 'package:dtvideo/pages/videos.dart';
import 'package:dtvideo/provider/apiprovider.dart';
import 'package:dtvideo/utils/color.dart';
import 'package:dtvideo/utils/customwidget.dart';
import 'package:dtvideo/widget/ibarraText.dart';
import 'package:dtvideo/widget/language.dart';
import 'package:dtvideo/widget/mynetworkimg.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:provider/provider.dart';

class Categorypage extends StatefulWidget {
  const Categorypage({Key? key}) : super(key: key);

  @override
  State<Categorypage> createState() => CategorypageState();
}

class CategorypageState extends State<Categorypage> {
  @override
  void initState() {
    final homeitem = Provider.of<ApiProvider>(context, listen: false);
    homeitem.categorylist(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: LanguageText(
            color: white,
            text: "Category",
            fontsize: 16,
            maxline: 1,
            fontwaight: FontWeight.w600,
            textalign: TextAlign.center,
            fontstyle: FontStyle.normal),
        backgroundColor: primary,
      ),
      body: SingleChildScrollView(
        // physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            categoryPage(),
          ],
        ),
      ),
    );
  }

  Widget categoryPage() {
    return Consumer<ApiProvider>(builder: (context, categoryprovider, child) {
      if (!categoryprovider.loading) {
        return categoryshimmer();
      } else {
        if (categoryprovider.categorylistmodel.status == 200 &&
            (categoryprovider.categorylistmodel.result?.length ?? 0) > 0) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: primary,
            child: GridView.builder(
              physics: const ScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
                crossAxisSpacing: 3,
                mainAxisSpacing: 3,
              ),
              itemCount: categoryprovider.categorylistmodel.result?.length ?? 0,
              shrinkWrap: true,
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
                      Container(
                        decoration: BoxDecoration(
                          border: const GradientBoxBorder(
                              width: 4,
                              gradient: LinearGradient(colors: [
                                categorygradiantBorderOne,
                                categorygradiantBorderTwo
                              ])),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: MyNetworkImage(
                            width: 85,
                            height: 85,
                            imagePath: categoryprovider
                                    .categorylistmodel.result?[index].image
                                    .toString() ??
                                "https://i.pinimg.com/564x/5d/69/42/5d6942c6dff12bd3f960eb30c5fdd0f9.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
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
                            fontwaight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
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

  Widget categoryshimmer() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: primary,
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 0,
        mainAxisSpacing: 5,
        shrinkWrap: true,
        children: List.generate(
          15,
          (index) {
            return Column(
              children: const [
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 5, 5, 5),
                  child: CustomWidget.circular(
                    width: 80,
                    height: 80,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: CustomWidget.roundrectborder(height: 5, width: 80),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
