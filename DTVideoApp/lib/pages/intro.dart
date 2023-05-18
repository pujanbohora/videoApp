import 'package:dtvideo/pages/bottonnavigation.dart';
import 'package:dtvideo/pages/home.dart';
import 'package:dtvideo/utils/color.dart';
import 'package:dtvideo/utils/sharedpre.dart';
import 'package:dtvideo/widget/myimage.dart';
import 'package:dtvideo/widget/mytext.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Intro extends StatefulWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  List<String> introBigtext = <String>[
    "See the music, hear the dance.",
    "I dance but I'm not a dancer",
    "It's those small moments on stage that are really special",
  ];

  List<String> introSmalltext = <String>[
    "Lörem ipsum hexaren lura infrasysam, utan preguras. Gyk kron hade pokaling. Nätdeklarant kvasin i full planat.Monodis dins. Rear hexaledes. Spera prelande polysasera för att gyling. ",
    "Lörem ipsum hexaren lura infrasysam, utan preguras. Gyk kron hade pokaling. Nätdeklarant kvasin i full planat.Monodis dins. Rear hexaledes. Spera prelande polysasera för att gyling. ",
    "Lörem ipsum hexaren lura infrasysam, utan preguras. Gyk kron hade pokaling. Nätdeklarant kvasin i full planat.Monodis dins. Rear hexaledes. Spera prelande polysasera för att gyling. ",
  ];

  List<String> introPager = <String>[
    "assets/images/introOne.png",
    "assets/images/introTwo.png",
    "assets/images/introThree.png",
  ];

  PageController pageController = PageController();
  final currentPageNotifier = ValueNotifier<int>(0);
  int pos = 0;
  SharedPre sharedPre = SharedPre();

  Future chack() async {
    await sharedPre.save("seen", "1");
  }

  Widget setText() {
    debugPrint("pos top:$pos");
    return MyText(
        color: white,
        text: pos == introPager.length - 1 ? "Finish" : "Skip",
        maxline: 1,
        overflow: TextOverflow.ellipsis,
        fontsize: 12,
        fontwaight: FontWeight.w500,
        textalign: TextAlign.center,
        fontstyle: FontStyle.normal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: intoPageview(),
    );
  }

  Widget intoPageview() {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: primary,
          alignment: Alignment.center,
          child: PageView.builder(
            itemCount: introPager.length,
            controller: pageController,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: MyImage(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          fit: BoxFit.fill,
                          imagePath: introPager[index]),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 180),
                          child: Container(
                            width: 300,
                            height: 150,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MyText(
                                    color: white,
                                    maxline: 2,
                                    text: introBigtext[index],
                                    textalign: TextAlign.center,
                                    fontsize: 20,
                                    fontwaight: FontWeight.w600,
                                    fontstyle: FontStyle.normal),
                                const SizedBox(
                                  height: 20,
                                ),
                                MyText(
                                    color: white,
                                    maxline: 2,
                                    text: introSmalltext[index],
                                    textalign: TextAlign.center,
                                    fontsize: 12,
                                    fontwaight: FontWeight.w600,
                                    fontstyle: FontStyle.normal),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            onPageChanged: (index) {
              pos = index;
              currentPageNotifier.value = index;
              debugPrint("pos:$pos");
              setState(() {
                setText();
              });
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 120),
            child: InkWell(
              onTap: () {
                if (pos == introPager.length - 1) {
                  chack();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const BottomNavigation();
                      },
                    ),
                  );
                }
                pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn);
              },
              child: Container(
                width: 100,
                height: 40,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: intronextBtn,
                    borderRadius: BorderRadius.all(Radius.circular(51))),
                child: MyText(
                    color: white,
                    text: pos == introPager.length - 1 ? "Finish" : "Next",
                    fontsize: 14,
                    fontwaight: FontWeight.w600,
                    textalign: TextAlign.center,
                    fontstyle: FontStyle.normal),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: SmoothPageIndicator(
              controller: pageController,
              count: introPager.length,
              axisDirection: Axis.horizontal,
              effect: const WormEffect(
                  spacing: 10.0,
                  radius: 10.0,
                  dotWidth: 7.0,
                  dotHeight: 7.0,
                  dotColor: black,
                  activeDotColor: white),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 40, 15, 0),
            child: GestureDetector(
              onTap: () {
                debugPrint("pos:$pos");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
                chack();
              },
              child: setText(),
            ),
          ),
        ),
      ],
    );
  }
}
