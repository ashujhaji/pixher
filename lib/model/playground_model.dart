import 'dart:isolate';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

import '../widget/image_widget.dart';
import '../widget/text_widget.dart';

class Playground {
  bool animated, available;
  AnimationController? animationController;
  List<Animation<double>>? animation;

  Playground({
    this.animationController,
    this.animated = false,
    this.available = true,
    this.animation,
  });

  factory Playground.getParamsFromKey(
      int? templateId, TickerProvider tickerProvider) {
    switch (templateId) {
      case 42:
        {
          AnimationController controller = AnimationController(
              duration: const Duration(milliseconds: 1000),
              vsync: tickerProvider);
          Animation<double> anim =
              Tween<double>(begin: 0, end: 25).animate(controller);
          return Playground(
            animated: true,
            animation: [anim],
            animationController: controller,
          );
        }
      case 48:
        {
          AnimationController controller = AnimationController(
              duration: const Duration(milliseconds: 1000),
              vsync: tickerProvider);
          Animation<double> anim =
              Tween<double>(begin: 0, end: 1).animate(controller);
          return Playground(
            animated: true,
            animation: [anim],
            animationController: controller,
          );
        }
      case 82:
        {
          AnimationController controller = AnimationController(
              duration: const Duration(milliseconds: 1500),
              vsync: tickerProvider);
          Animation<double> imgAnim = Tween<double>(begin: 200, end: 0).animate(
            CurvedAnimation(
              parent: controller,
              curve: const Interval(
                0,
                0.65,
                curve: Curves.easeInOut,
              ),
            ),
          );
          Animation<double> textAnim = Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(
              parent: controller,
              curve: const Interval(
                0.65,
                1,
                curve: Curves.easeInOut,
              ),
            ),
          );
          return Playground(
            animated: true,
            animation: [imgAnim, textAnim],
            animationController: controller,
          );
        }
      case 92:
        {
          AnimationController controller = AnimationController(
              duration: const Duration(milliseconds: 1200),
              vsync: tickerProvider);
          Animation<double> imgAnim =
              Tween<double>(begin: 1, end: 0).animate(controller);
          return Playground(
            animated: true,
            animation: [imgAnim],
            animationController: controller,
          );
        }
      case 94:
        {
          AnimationController controller = AnimationController(
              duration: const Duration(milliseconds: 1000),
              vsync: tickerProvider);
          Animation<double> imgAnim =
              Tween<double>(begin: 1, end: 0).animate(controller);
          return Playground(
            animated: true,
            animation: [imgAnim],
            animationController: controller,
          );
        }
      case 96:
        {
          AnimationController controller = AnimationController(
              duration: const Duration(milliseconds: 1000),
              vsync: tickerProvider);
          Animation<double> imgAnim =
              Tween<double>(begin: 0, end: 1).animate(controller);
          return Playground(
            animated: true,
            animation: [imgAnim],
            animationController: controller,
          );
        }
      case 125:
        {
          AnimationController controller = AnimationController(
              duration: const Duration(milliseconds: 1500),
              vsync: tickerProvider);
          Animation<double> imgOne = Tween<double>(begin: 1, end: 0).animate(
            CurvedAnimation(
              parent: controller,
              curve: const Interval(
                0,
                0.65,
                curve: Curves.easeInOut,
              ),
            ),
          );
          Animation<double> imgTwo = Tween<double>(begin: 1, end: 0).animate(
            CurvedAnimation(
              parent: controller,
              curve: const Interval(
                0.65,
                1,
                curve: Curves.easeInOut,
              ),
            ),
          );
          return Playground(
            animated: true,
            animation: [imgOne, imgTwo],
            animationController: controller,
          );
        }
      default:
        {
          return Playground(
              //available: false,
              );
        }
    }
  }
}

Widget playgroundWidget(BuildContext context, int templateId,
    {List<Animation<double>>? animations,
    String? assetUrl,
    bool animated = false}) {
  if (animations == null && animated) return Container();
  switch (templateId) {
    case 42:
      {
        return Container(
          color: Colors.white,
          child: ImageWidget(),
          padding: EdgeInsets.all(animations![0].value),
        );
      }
    case 48:
      {
        return Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding:
                      EdgeInsets.only(bottom: (1 - animations![0].value) * 100),
                  child: ImageWidget(),
                ),
                flex: 5,
              ),
              Expanded(
                child: Column(
                  children: [
                    TextWidget(
                      textStyle: GoogleFonts.ebGaramond(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      hint: 'Finding Balance',
                    ),
                    TextWidget(
                      textStyle: GoogleFonts.ebGaramond(
                        color: Colors.black45,
                        fontSize: 14,
                      ),
                      hint:
                          'When I find myself in a creative block I always find it reenergizing to explore the water.',
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                ),
                flex: 2,
              ),
            ],
          ),
          padding: const EdgeInsets.all(20),
        );
      }
    case 54:
      {
        return Container(
          color: Colors.white.withOpacity(0.9),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 30),
                child: CachedNetworkImage(
                  imageUrl: assetUrl.toString(),
                  width: MediaQuery.of(context).size.width / 3,
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  color: Colors.white,
                  child: ImageWidget(
                    opacity: Colors.black.withOpacity(0.25),
                  ),
                  width: MediaQuery.of(context).size.height / 3.2,
                  height: MediaQuery.of(context).size.height / 2,
                  margin: const EdgeInsets.only(top: 30),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  margin: const EdgeInsets.all(30),
                  child: Card(
                    child: Stack(
                      children: [
                        Align(
                          child: Column(
                            children: [
                              TextWidget(
                                hint:
                                    'SAVE THE DATE\nSEPT 22, 2022\nAQUA HOTEL NYC',
                                textStyle: GoogleFonts.ebGaramond(
                                  color: Colors.brown,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextWidget(
                                hint: 'Johnathan Limer \n& \nSamanthe Colon',
                                textStyle: GoogleFonts.satisfy(
                                  color: Colors.brown,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(math.pi),
                            child: CachedNetworkImage(
                              imageUrl: assetUrl.toString(),
                              width: 70,
                            ),
                          ),
                        )
                      ],
                    ),
                    color: Colors.white,
                  ),
                  width: MediaQuery.of(context).size.height / 3.2,
                  height: MediaQuery.of(context).size.height / 2.5,
                ),
              ),
            ],
          ),
          //padding: const EdgeInsets.all(20),
        );
      }
    case 61:
      {
        return Container(
          color: Colors.white.withOpacity(0.9),
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: assetUrl.toString(),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: const EdgeInsets.only(top: 200, left: 60),
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.width,
                  child: RotationTransition(
                    turns: const AlwaysStoppedAnimation(5 / 360),
                    child: ImageWidget(),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                    padding: const EdgeInsets.only(bottom: 190, right: 60),
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.width,
                    child: RotationTransition(
                      turns: const AlwaysStoppedAnimation(345 / 360),
                      child: ImageWidget(),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 145),
                child: Align(
                  child: TextWidget(
                    hint: 'Ashutosh Jha',
                    textStyle: GoogleFonts.gideonRoman(
                      color: Colors.black.withOpacity(0.7),
                      fontSize: 20,
                    ),
                  ),
                  alignment: Alignment.topCenter,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 60, bottom: 110),
                child: Align(
                  child: TextWidget(
                    hint: 'With all \nthe best wishes',
                    textStyle: GoogleFonts.gideonRoman(
                      color: Colors.black.withOpacity(0.7),
                      fontSize: 12,
                    ),
                  ),
                  alignment: Alignment.bottomRight,
                ),
              ),
            ],
          ),
          //padding: const EdgeInsets.all(20),
        );
      }

    case 67:
      {
        return Container(
          color: Colors.white.withOpacity(0.9),
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: assetUrl.toString(),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 120),
                child: Align(
                  child: TextWidget(
                    hint: 'Wish you growth with healthy\n& happiness',
                    textStyle: GoogleFonts.roboto(
                        color: const Color(0xffe3cfc3),
                        fontSize: 16,
                        letterSpacing: 2.2),
                  ),
                  alignment: Alignment.bottomCenter,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 120,
                  bottom: 270,
                  left: 50,
                  right: 50,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                    child: ImageWidget(),
                  ),
                ),
              ),
            ],
          ),
          //padding: const EdgeInsets.all(20),
        );
      }
    case 71:
      {
        return Container(
          color: const Color(0xfff8f1f1),
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: assetUrl.toString(),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 10, left: 15, right: 15, bottom: 35),
                        child: ImageWidget(),
                      ),
                    ],
                  ),
                  margin: const EdgeInsets.only(
                      top: 30, left: 30, right: 30, bottom: 15),
                ),
                flex: 1,
              ),
              Expanded(
                child: Container(
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: assetUrl.toString(),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 10, left: 15, right: 15, bottom: 35),
                        child: ImageWidget(),
                      ),
                    ],
                  ),
                  margin: const EdgeInsets.only(
                      top: 10, left: 30, right: 30, bottom: 30),
                ),
                flex: 1,
              ),
            ],
          ),
          //padding: const EdgeInsets.all(20),
        );
      }
    case 75:
      {
        return Container(
          color: Colors.white,
          child: Stack(
            children: [
              CachedNetworkImage(imageUrl: assetUrl.toString()),
              Center(
                child: Container(
                  height: 230,
                  width: 230,
                  alignment: Alignment.center,
                  child: ImageWidget(),
                  color: Colors.lightBlueAccent.withOpacity(0.4),
                  margin: const EdgeInsets.all(30),
                  padding: const EdgeInsets.all(10),
                ),
              ),
            ],
          ),
          //padding: const EdgeInsets.all(20),
        );
      }
    case 82:
      {
        return Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(bottom: animations![0].value),
                  child: ImageWidget(),
                  margin: const EdgeInsets.all(30),
                ),
                flex: 6,
              ),
              Expanded(
                child: Center(
                  child: Opacity(
                    child: TextWidget(
                      textStyle: GoogleFonts.satisfy(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 35,
                      ),
                      hint: 'Venice Beach',
                    ),
                    opacity: animations[1].value,
                  ),
                ),
                flex: 2,
              ),
            ],
          ),
          //padding: const EdgeInsets.all(20),
        );
      }
    case 88:
      {
        return Container(
          color: Colors.white,
          child: Stack(
            children: [
              CachedNetworkImage(imageUrl: assetUrl.toString()),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      textStyle: GoogleFonts.satisfy(
                        color: const Color(0xff532e1d),
                        fontSize: 60,
                      ),
                      hint: 'Happy Birthday, Kimmy!',
                    ),
                    TextWidget(
                      textStyle: GoogleFonts.lato(
                        color: const Color(0xff532e1d),
                        fontSize: 20,
                      ),
                      hint: 'Have a good one!',
                    ),
                  ],
                ),
              ),
            ],
          ),
          //padding: const EdgeInsets.all(20),
        );
      }
    case 92:
      {
        return Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: Align(
                  child: Container(
                    padding: EdgeInsets.only(
                        top: 20,
                        right: 20,
                        bottom: (animations![0].value *
                                MediaQuery.of(context).size.width) +
                            10),
                    width: MediaQuery.of(context).size.width * 2 / 3,
                    child: ImageWidget(),
                  ),
                  alignment: Alignment.topRight,
                ),
                flex: 1,
              ),
              Expanded(
                child: Align(
                  child: Container(
                    padding: EdgeInsets.only(
                        top: (animations[0].value *
                                MediaQuery.of(context).size.width) +
                            10,
                        left: 20,
                        bottom: 20),
                    width: MediaQuery.of(context).size.width * 2 / 3,
                    child: ImageWidget(),
                  ),
                  alignment: Alignment.bottomLeft,
                ),
                flex: 1,
              ),
            ],
          ),
          //padding: const EdgeInsets.all(20),
        );
      }
    case 94:
      {
        return Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: Align(
                  child: Container(
                    padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width *
                            animations![0].value),
                    child: ImageWidget(),
                  ),
                  alignment: Alignment.topRight,
                ),
                flex: 1,
              ),
              Expanded(
                child: Align(
                  child: Container(
                    padding: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                        left: MediaQuery.of(context).size.width *
                            animations[0].value),
                    child: ImageWidget(),
                  ),
                  alignment: Alignment.topRight,
                ),
                flex: 1,
              ),
              Expanded(
                child: Align(
                  child: Container(
                    padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width *
                            animations[0].value),
                    child: ImageWidget(),
                  ),
                  alignment: Alignment.bottomLeft,
                ),
                flex: 1,
              ),
            ],
          ),
          //padding: const EdgeInsets.all(20),
        );
      }
    case 96:
      {
        return Container(
          color: Colors.white,
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: Align(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.width *
                            animations![0].value,
                        child: ImageWidget(),
                      ),
                      alignment: Alignment.topRight,
                    ),
                    flex: 2,
                  ),
                  const Expanded(
                    child: SizedBox(),
                    flex: 1,
                  ),
                  Expanded(
                    child: Align(
                      child: Container(
                        width: MediaQuery.of(context).size.width *
                            animations[0].value,
                        padding: const EdgeInsets.all(20),
                        child: ImageWidget(),
                      ),
                      alignment: Alignment.center,
                    ),
                    flex: 2,
                  ),
                ],
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextWidget(
                        textStyle: GoogleFonts.satisfy(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        hint: 'adventuring in',
                      ),
                      TextWidget(
                        textStyle: GoogleFonts.merriweather(
                          color: Colors.black,
                          fontSize: 24,
                        ),
                        hint: 'IRELAND',
                      ),
                      TextWidget(
                        textStyle: GoogleFonts.lato(
                          color: Colors.black,
                          fontSize: 12,
                          height: 2,
                        ),
                        hint:
                            'The past couple of days have been a dream, I knew the landscape in Ireland was going to be breathtaking, but I had no idea how gorgeous it truly was till I saw it for myself.',
                      )
                    ],
                    mainAxisSize: MainAxisSize.min,
                  ),
                  color: Colors.white,
                ),
              )
            ],
          ),
          //padding: const EdgeInsets.all(20),
        );
      }
    case 100:
      {
        return Container(
          color: Colors.white,
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: assetUrl.toString(),
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 80,
                left: 25,
                child: TextWidget(
                  textStyle: GoogleFonts.allura(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 30,
                  ),
                  hint: 'Mother\'s love...',
                ),
              ),
              Center(
                child: Container(
                  child: ImageWidget(),
                  margin: const EdgeInsets.only(
                    top: 170,
                    bottom: 210,
                    left: 80,
                    right: 80,
                  ),
                ),
              )
            ],
          ),
          //padding: const EdgeInsets.all(20),
        );
      }
    case 106:
      {
        return Container(
          color: Colors.white,
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(MediaQuery.of(context).size.width),
                  child: ImageWidget(),
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width - 50,
              ),
              TextWidget(
                textStyle: GoogleFonts.neuton(
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 12,
                    letterSpacing: 1),
              ),
              TextWidget(
                textStyle: GoogleFonts.neuton(
                  color: Colors.black.withOpacity(0.7),
                  fontSize: 22,
                  letterSpacing: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextWidget(
                  textStyle: GoogleFonts.neuton(
                      color: Colors.black.withOpacity(0.7),
                      fontSize: 12,
                      letterSpacing: 1),
                ),
              ),
            ],
          ),
          //padding: const EdgeInsets.all(20),
        );
      }
    case 110:
      {
        return Container(
          color: Colors.white,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: assetUrl.toString(),
                fit: BoxFit.cover,
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  TextWidget(
                    textStyle: GoogleFonts.neuton(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 22,
                        letterSpacing: 1),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextWidget(
                    textStyle: GoogleFonts.satisfy(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 48,
                        letterSpacing: 1),
                  ),
                ],
              )
            ],
          ),
          //padding: const EdgeInsets.all(20),
        );
      }
    case 118:
      {
        return Container(
          color: Colors.white,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(imageUrl: assetUrl.toString()),
              Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  TextWidget(
                    textStyle: GoogleFonts.satisfy(
                        color: Colors.black, fontSize: 32, letterSpacing: 1),
                    hint: 'Love yourself',
                  ),
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                            padding: const EdgeInsets.only(
                                bottom: 170, right: 10, left: 50, top: 30),
                            width: MediaQuery.of(context).size.width / 2,
                            height: MediaQuery.of(context).size.width,
                            child: RotationTransition(
                              turns: const AlwaysStoppedAnimation(345 / 360),
                              child: PhysicalModel(
                                color: Colors.white,
                                child: ImageWidget(),
                                elevation: 5,
                              ),
                            )),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          padding: const EdgeInsets.only(top: 200, right: 30),
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.width,
                          child: RotationTransition(
                            turns: const AlwaysStoppedAnimation(5 / 360),
                            child: PhysicalModel(
                              color: Colors.white,
                              child: ImageWidget(),
                              elevation: 8,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        );
      }
    case 122:
      {
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width - 70,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: ImageWidget(
                    filter: ColorFilter.mode(
                      Colors.black.withOpacity(1),
                      BlendMode.saturation,
                    ),
                  ),
                ),
              )
            ],
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        );
      }
    case 125:
      {
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(
                          left: (MediaQuery.of(context).size.width / 3 - 10) *
                              animations![1].value,
                        ),
                        child: ImageWidget(),
                      ),
                      flex: 1,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width *
                              animations[0].value,
                        ),
                        child: ImageWidget(),
                      ),
                      flex: 2,
                    ),
                  ],
                ),
                flex: 5,
              ),
              Expanded(
                child: AnimatedOpacity(
                  opacity: 1 - animations[0].value,
                  duration: const Duration(seconds: 3),
                  child: Column(
                    children: [
                      TextWidget(
                        textStyle: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 22,
                        ),
                        hint: 'New\nCollection',
                        edgeInsetsGeometry: EdgeInsets.zero,
                      ),
                      TextWidget(
                        textStyle: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        hint: 'Spring/Summer',
                        edgeInsetsGeometry: EdgeInsets.zero,
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),
                flex: 3,
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width *
                              animations[0].value,
                        ),
                        child: ImageWidget(),
                      ),
                      flex: 2,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(
                          right: (MediaQuery.of(context).size.width / 3 - 10) *
                              animations[1].value,
                        ),
                        child: ImageWidget(),
                      ),
                      flex: 1,
                    ),
                  ],
                ),
                flex: 5,
              ),
            ],
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        );
      }
    case 128:
      {
        return Container(
          color: const Color(0xfff2ead0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 40,
                      top: 40,
                    ),
                    child: TextWidget(
                      textStyle: GoogleFonts.exo2(
                        color: Colors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                      ),
                      hint: 'New arrivals',
                      edgeInsetsGeometry: EdgeInsets.zero,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 40,
                    ),
                    child: TextWidget(
                      textStyle: GoogleFonts.mavenPro(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 12,
                      ),
                      hint: 'Discount up to 60% on all items',
                      edgeInsetsGeometry: EdgeInsets.zero,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(150),
                          bottomRight: Radius.circular(150),
                        ),
                        child: ImageWidget(),
                      ),
                      margin:
                          const EdgeInsets.only(top: 40, bottom: 20, right: 50),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }
    case 131:
      {
        return Container(
          color: const Color(0xffebe6e0),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  child: TextWidget(
                    textStyle: GoogleFonts.taviraj(
                      color: const Color(0xff6f4930).withOpacity(0.8),
                      fontSize: 110,
                      fontWeight: FontWeight.w500,
                    ),
                    hint: 'SALE',
                    edgeInsetsGeometry: EdgeInsets.zero,
                  ),
                  padding: const EdgeInsets.all(20),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  color: Colors.white,
                  child: ImageWidget(),
                  padding: const EdgeInsets.all(10),
                  /*width: 250,
                  height: 230,*/
                  margin: const EdgeInsets.only(
                      left: 60, right: 60, top: 115, bottom: 80),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  child: RotationTransition(
                    turns: const AlwaysStoppedAnimation(340 / 360),
                    child: TextWidget(
                      textStyle: GoogleFonts.ruthie(
                        color: Colors.black,
                        fontSize: 28,
                      ),
                      hint: 'elegance is beauty\nthat never fades',
                      edgeInsetsGeometry: EdgeInsets.zero,
                    ),
                  ),
                  padding: const EdgeInsets.only(bottom: 80, right: 50),
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: TextWidget(
                      textStyle: GoogleFonts.roboto(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: 14,
                      ),
                      hint: 'www.mywebsite.com',
                      edgeInsetsGeometry: EdgeInsets.zero,
                    ),
                  )),
            ],
          ),
        );
      }
    case 143:
      {
        return Container(
          color: Colors.white,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(imageUrl: assetUrl.toString()),
              Stack(
                children: [
                  Positioned(
                    top: 55.0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: TextWidget(
                        textStyle: GoogleFonts.slabo13px(
                            color: Colors.black.withOpacity(0.7), fontSize: 16),
                        hint: 'WE ARE GETTING MARRIED',
                      ),
                    ),
                  ),
                  Positioned(
                    top: 345.0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: TextWidget(
                        textStyle: GoogleFonts.ooohBaby(
                            color: Colors.black, fontSize: 26),
                        hint: 'Marceline & Jonathan',
                      ),
                    ),
                  ),
                  Positioned(
                    top: 415.0,
                    left: 40,
                    right: 40,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: TextWidget(
                        textStyle: GoogleFonts.slabo13px(
                            color: Colors.black.withOpacity(0.8), fontSize: 16),
                        hint:
                            'We\'d love your presence to be a part of our big day!',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        bottom: 45, right: 63, left: 67, top: 125),
                    height: MediaQuery.of(context).size.width,
                    child: RotationTransition(
                      turns: const AlwaysStoppedAnimation(359 / 360),
                      child: Container(
                        color: Colors.white,
                        child: ImageWidget(),
                        //elevation: 5,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 520,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: TextWidget(
                        textStyle: GoogleFonts.slabo13px(
                            color: Colors.black, fontSize: 14),
                        hint:
                            'FRIDAY, 09.09.2022\n123 Anywhere St. Any City, ST 12345',
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      }
    case 152:
      {
        return Container(
          color: Colors.white,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: assetUrl.toString(),
                fit: BoxFit.cover,
              ),
              Container(
                child: Column(
                  children: [
                    TextWidget(
                      hint: 'Have a happy and safe Diwali.',
                      textStyle: GoogleFonts.greatVibes(
                          color: const Color(0xfffdc984),
                          fontSize: 22,
                          height: 1.5),
                    ),
                    TextWidget(
                      hint: 'From Pixher & Family',
                      textStyle: GoogleFonts.roboto(
                          color: const Color(0xfffdc984),
                          fontSize: 12,
                          height: 1.5),
                    )
                  ],
                ),
                margin: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width / 2,
                  bottom: 150,
                  left: 20,
                  top: 20,
                ),
              )
            ],
          ),
        );
      }
    case 163:
      {
        return Container(
          color: Colors.white,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: assetUrl.toString(),
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 75,
                left: 200,
                child: Column(
                  children: [
                    TextWidget(
                      textStyle: GoogleFonts.allura(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w700),
                      hint: 'Happy',
                      edgeInsetsGeometry: EdgeInsets.zero,
                    ),
                    TextWidget(
                      textStyle: GoogleFonts.allura(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600),
                      hint: 'Diwali',
                      edgeInsetsGeometry: EdgeInsets.zero,
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 10,
                left: 250,
                right: 20,
                child: TextWidget(
                  textStyle: GoogleFonts.lato(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 12,
                      fontWeight: FontWeight.w700),
                  hint: 'From Pixher & Family',
                  edgeInsetsGeometry: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        );
      }
    case 167:
      {
        return Container(
          color: Colors.white,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: assetUrl.toString(),
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 85,
                left: 125,
                child: ClipRRect(
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ImageWidget(
                      filter: ColorFilter.mode(
                        Colors.black.withOpacity(1),
                        BlendMode.saturation,
                      ),
                    ),
                  ),
                  borderRadius: BorderRadius.circular(25),
                )
              ),
            ],
          ),
        );
      }
    case 171:
      {
        return Container(
          color: Colors.white,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: assetUrl.toString(),
                fit: BoxFit.cover,
              ),
              Positioned(
                  top: 70,
                  right: 40,
                  child: ClipRRect(
                    child: Container(
                      width: 130,
                      height: 200,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ImageWidget(
                        filter: ColorFilter.mode(
                          Colors.black.withOpacity(1),
                          BlendMode.saturation,
                        ),
                      ),
                    ),
                    borderRadius: BorderRadius.circular(15),
                  )
              ),
            ],
          ),
        );
      }
    default:
      {
        return _updateWidget(context);
      }
  }
}

Widget _updateWidget(BuildContext context) {
  return Column(
    children: [
      Column(
        children: [
          Image.asset(
            'assets/images/ic_update.png',
            height: 200,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Hey! You loved this template?\n\nWe have designed lot of new templates and more amazing features for you.\nUpdate the app to avail it now.',
            style: Theme.of(context).textTheme.headline6?.copyWith(height: 1.5),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      Column(
        children: [
          Text(
            'Made with ❤ in  🇮🇳',
            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  height: 1.5,
                ),
            textAlign: TextAlign.center,
          ),
          InkWell(
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(vertical: 10),
              height: 44,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context)
                      .floatingActionButtonTheme
                      .backgroundColor),
              child: Text(
                'Update the app',
                style: Theme.of(context).textTheme.headline6,
              ),
              alignment: Alignment.center,
            ),
            onTap: () {},
          ),
        ],
      ),
    ],
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
  );
}
