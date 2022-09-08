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

Widget playgroundWidget(
  BuildContext context,
  int templateId,
  ValueChanged<bool> contentAvailable, {
  List<Animation<double>>? animations,
  String? assetUrl,
  bool animated = false,
}) {
  if (animations == null && animated) return Container();
  switch (templateId) {
    case 42:
    case 320:
      {
        return Container(
          color: Colors.white,
          child: ImageWidget(
          ),
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
                    child: ImageWidget(
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.width,
                    ),
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
                      child: ImageWidget(
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.width,
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 145),
                child: Align(
                  child: TextWidget(
                    hint: 'Olivia',
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
                  child: ImageWidget(
                    width: 230,
                    height: 230,
                  ),
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
          padding: const EdgeInsets.all(20),
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
    case 360:
    case 280:
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
    case 327:
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
    case 275:
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
    case 271:
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
                      textStyle: GoogleFonts.greatVibes(
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
                    top: 360.0,
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
                    top: 425.0,
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
                    bottom: 80,
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
                        width: 150,
                        height: 150,
                      ),
                    ),
                    borderRadius: BorderRadius.circular(25),
                  )),
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
                      width: 130,
                      height: 200,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ],
          ),
        );
      }
    case 175:
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
                    hint: 'VIRTUAL DIWALI EVENT',
                    textStyle: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 14,
                        height: 1.5,
                        letterSpacing: 1.5),
                  ),
                  TextWidget(
                    hint: 'OCT 22, 2022',
                    textStyle: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 12,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w700,
                    ),
                    edgeInsetsGeometry: EdgeInsets.zero,
                  ),
                  TextWidget(
                    hint: 'Light up the darkness',
                    textStyle: GoogleFonts.lobsterTwo(
                      color: const Color(0xffff7ebb),
                      fontSize: 24,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w700,
                    ),
                    edgeInsetsGeometry: EdgeInsets.zero,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: TextWidget(
                      hint:
                          'We will host performances, free dance, raffles and a special candle-lighting ceremony to unite with light.',
                      textStyle: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 12,
                        height: 1.5,
                      ),
                      edgeInsetsGeometry: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 35,
                left: 20,
                child: ClipRRect(
                  child: Container(
                    width: 130,
                    height: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: TextWidget(
                      hint: 'www.pixher.app',
                      textStyle: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 14,
                        height: 1.5,
                      ),
                      edgeInsetsGeometry: EdgeInsets.zero,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ],
          ),
        );
      }
    case 179:
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
                    height: 35,
                  ),
                  TextWidget(
                    hint: 'VIRTUAL DIWALI EVENT',
                    textStyle: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 10,
                        height: 1.5,
                        letterSpacing: 1.5),
                  ),
                  Container(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(300),
                        bottomLeft: Radius.circular(300),
                      ),
                      child: ImageWidget(
                        height:
                            (MediaQuery.of(context).size.height * 2 / 3) - 100,
                      ),
                    ),
                    margin: const EdgeInsets.only(left: 150, top: 60),
                    height: (MediaQuery.of(context).size.height * 2 / 3) - 100,
                  ),
                ],
              ),
              Positioned(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      hint: 'NOV 14, 2022',
                      textStyle: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 12,
                        height: 1.5,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.start,
                      edgeInsetsGeometry: EdgeInsets.zero,
                    ),
                    TextWidget(
                      hint: 'A festival of lights, good over evil',
                      textStyle: GoogleFonts.lobsterTwo(
                        color: const Color(0xffff7ebb),
                        fontSize: 24,
                        height: 1.5,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    TextWidget(
                      hint:
                          'We will host performances, free dance, raffles and a special candle-lighting ceremony to unite with light.',
                      textStyle: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 10,
                        height: 1.7,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.start,
                      edgeInsetsGeometry: EdgeInsets.zero,
                    ),
                  ],
                  mainAxisSize: MainAxisSize.min,
                ),
                left: 20,
                right: (MediaQuery.of(context).size.width / 2) + 10,
                top: (MediaQuery.of(context).size.height / 2) - 60,
              ),
              Positioned(
                child: TextWidget(
                  hint: 'Please register in www.diwalilight.com',
                  textStyle: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 10,
                    height: 1.5,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                bottom: 30,
                left: 20,
              ),
            ],
          ),
        );
      }
    case 188:
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
                child: Column(
                  children: [
                    TextWidget(
                      hint: 'BIGGEST DIWALI SALE',
                      textStyle: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 24,
                          height: 1.1,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w700),
                      edgeInsetsGeometry: EdgeInsets.zero,
                    ),
                    TextWidget(
                      hint: '80%',
                      textStyle: GoogleFonts.oswald(
                          color: Colors.white,
                          fontSize: 50,
                          fontWeight: FontWeight.w700),
                      edgeInsetsGeometry: EdgeInsets.zero,
                    ),
                    TextWidget(
                      hint: 'OFF ON ENTIRE STORE',
                      textStyle: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 14,
                          height: 1.1,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w700),
                      edgeInsetsGeometry: EdgeInsets.zero,
                    ),
                  ],
                ),
                left: 90,
                right: 90,
                top: 90,
              ),
              Positioned(
                child: Column(
                  children: [
                    TextWidget(
                      hint:
                          'Wishing you light and joy. This diwali grab the biggest discount ever.',
                      textStyle: GoogleFonts.openSans(
                        color: const Color(0xff000000),
                        fontSize: 12,
                        height: 2,
                        letterSpacing: 1,
                      ),
                      edgeInsetsGeometry: EdgeInsets.zero,
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    TextWidget(
                      hint: '@pixher.app',
                      textStyle: GoogleFonts.lato(
                        color: const Color(0xffff433b),
                        fontSize: 14,
                      ),
                    ),
                    Container(
                      child: TextWidget(
                        hint: 'Swipe Up',
                        textStyle: GoogleFonts.lato(
                            color: const Color(0xffff433b),
                            fontSize: 14,
                            height: 1.1,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.w700),
                        edgeInsetsGeometry: EdgeInsets.zero,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: const Color(0x2fff433b),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                    )
                  ],
                ),
                left: 90,
                right: 90,
                bottom: 5,
              ),
            ],
          ),
        );
      }
    case 192:
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
                child: Column(
                  children: [
                    TextWidget(
                      hint: 'HAPPY DIWALI',
                      textStyle: GoogleFonts.lato(
                          color: const Color(0xffbf9e5d),
                          fontSize: 12,
                          height: 1,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w700),
                      edgeInsetsGeometry: EdgeInsets.zero,
                    ),
                    TextWidget(
                      hint: 'OFFERS',
                      textStyle: GoogleFonts.unicaOne(
                        color: Colors.white,
                        fontSize: 100,
                      ),
                      edgeInsetsGeometry: EdgeInsets.zero,
                    ),
                    TextWidget(
                      hint: 'EXTRA CASHBACK ON PREPAID ORDERS',
                      textStyle: GoogleFonts.poppins(
                        color: const Color(0xffbf9e5d),
                        fontSize: 14,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Container(
                      child: TextWidget(
                        hint: 'SHOP NOW',
                        textStyle: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 14,
                            height: 1.1,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.w700),
                      ),
                      color: const Color(0xffbf9e5d),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                    )
                  ],
                ),
                left: 20,
                right: 20,
                bottom: 20,
              ),
            ],
          ),
        );
      }
    case 196:
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: 120,
                    height: 120,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: ImageWidget(
                        width: 120,
                        height: 120,
                      ),
                    ),
                  ),
                  TextWidget(
                    hint: 'Wishing you light & joy',
                    textStyle: GoogleFonts.lato(
                      color: const Color(0xffffffff),
                      fontSize: 12,
                      height: 1,
                      letterSpacing: 1.5,
                    ),
                  ),
                  TextWidget(
                    hint: 'Happy Diwali',
                    textStyle: GoogleFonts.dancingScript(
                      color: Colors.white,
                      fontSize: 28,
                    ),
                    edgeInsetsGeometry: EdgeInsets.zero,
                  ),
                ],
              ),
              Positioned(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: TextWidget(
                    hint: 'From Pixher App',
                    textStyle: GoogleFonts.lato(
                      color: const Color(0xffffffff),
                      fontSize: 12,
                      height: 1,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                bottom: 10,
              ),
            ],
          ),
        );
      }
    case 200:
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  Container(
                    width: 120,
                    height: 180,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                      child: ImageWidget(
                        width: 120,
                        height: 180,
                      ),
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }
    case 206:
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
                child: Column(
                  children: [
                    TextWidget(
                      hint: 'FESTIVE SALE',
                      textStyle: GoogleFonts.lato(
                          color: const Color(0xffa84411),
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                      edgeInsetsGeometry: EdgeInsets.zero,
                    ),
                    TextWidget(
                      hint: '80%',
                      textStyle: GoogleFonts.oswald(
                          color: const Color(0xffa84411),
                          fontSize: 50,
                          fontWeight: FontWeight.w700),
                      edgeInsetsGeometry: EdgeInsets.zero,
                    ),
                    TextWidget(
                      hint: 'OFF ON ENTIRE STORE',
                      textStyle: GoogleFonts.lato(
                          color: const Color(0xffa84411),
                          fontSize: 14,
                          height: 1.1,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w700),
                      edgeInsetsGeometry: EdgeInsets.zero,
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                left: 90,
                right: 95,
                top: 165,
              ),
              Positioned(
                child: Container(
                    width: MediaQuery.of(context).size.width - 35,
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        TextWidget(
                          hint: 'Visit us on www.pixher.app',
                          textStyle: GoogleFonts.lato(
                            color: const Color(0xffa84411),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          child: TextWidget(
                            hint: 'Swipe Up',
                            textStyle: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 14,
                                height: 1.1,
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.w700),
                            edgeInsetsGeometry: EdgeInsets.zero,
                          ),
                          decoration: const BoxDecoration(
                            color: Color(0xffa84411),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                        ),
                      ],
                    )),
                bottom: 25,
              ),
            ],
          ),
        );
      }
    case 210:
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
                child: TextWidget(
                  hint: 'Happy Diwali',
                  textStyle: GoogleFonts.satisfy(
                    color: const Color(0xffffffff),
                    fontSize: 28,
                  ),
                  edgeInsetsGeometry: EdgeInsets.zero,
                ),
                left: 15,
                top: 15,
              ),
              Positioned(
                child: Column(
                  children: [
                    TextWidget(
                      hint: 'FESTIVE SALE',
                      textStyle: GoogleFonts.lato(
                          color: const Color(0xffa84411),
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                      edgeInsetsGeometry: EdgeInsets.zero,
                    ),
                    TextWidget(
                      hint: '80%',
                      textStyle: GoogleFonts.oswald(
                          color: const Color(0xffa84411),
                          fontSize: 50,
                          fontWeight: FontWeight.w700),
                      edgeInsetsGeometry: EdgeInsets.zero,
                    ),
                    TextWidget(
                      hint: 'OFF ON ENTIRE STORE',
                      textStyle: GoogleFonts.lato(
                          color: const Color(0xffa84411),
                          fontSize: 14,
                          height: 1.1,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w700),
                      edgeInsetsGeometry: EdgeInsets.zero,
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                left: 90,
                right: 95,
                top: 125,
              ),
              Positioned(
                child: TextWidget(
                  hint: '@pixher.app',
                  textStyle: GoogleFonts.lato(
                      color: const Color(0xffffffff),
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                  edgeInsetsGeometry: EdgeInsets.zero,
                ),
                right: 15,
                bottom: 15,
              ),
            ],
          ),
        );
      }
    case 214:
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
                          color: const Color(0xffff9d01),
                          fontSize: 24,
                          height: 1.5),
                    ),
                    TextWidget(
                      hint: 'From Pixher & Family',
                      textStyle: GoogleFonts.roboto(
                          color: const Color(0xffff9d01),
                          fontSize: 12,
                          height: 1.5),
                    )
                  ],
                ),
                margin: EdgeInsets.only(
                  right: (MediaQuery.of(context).size.width / 2) + 20,
                  bottom: 150,
                  top: 20,
                ),
              ),
              Positioned(
                child: TextWidget(
                  hint: 'www.pixher.app',
                  textStyle: GoogleFonts.roboto(
                    color: const Color(0xff00264a),
                    fontSize: 12,
                    height: 1.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                right: 10,
                bottom: 20,
              ),
            ],
          ),
        );
      }
    case 219:
      {
        return Container(
          color: Colors.transparent,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: assetUrl.toString(),
                fit: BoxFit.cover,
              ),
              Container(
                child: TextWidget(
                  hint: 'Wish you happiness & joy',
                  textStyle: GoogleFonts.greatVibes(
                      color: const Color(0xffd1ac3b),
                      fontSize: 24,
                      height: 1.5),
                ),
                margin: const EdgeInsets.only(right: 120, left: 120, top: 120),
              ),
              Positioned(
                child: TextWidget(
                  hint: 'www.pixher.app',
                  textStyle: GoogleFonts.lato(
                    color: const Color(0xffffffff),
                    fontSize: 12,
                    height: 1.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                right: 10,
                bottom: 10,
              ),
            ],
          ),
        );
      }
    case 223:
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
                  TextWidget(
                    hint: 'Happy Diwali',
                    textStyle: GoogleFonts.greatVibes(
                      color: const Color(0xffe0948f),
                      fontSize: 24,
                      height: 1.5,
                      fontWeight: FontWeight.w700,
                    ),
                    edgeInsetsGeometry: EdgeInsets.zero,
                  ),
                  TextWidget(
                    hint: 'Glowing Soul, Glowing Skin',
                    textStyle: GoogleFonts.lato(
                      color: const Color(0xff975c20),
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  Container(
                    width: 170,
                    height: 170,
                    child: ImageWidget(
                      width: 170,
                      height: 170,
                    ),
                    color: Colors.white,
                    padding: const EdgeInsets.all(10),
                  ),
                  TextWidget(
                    hint: 'Get special care for your skin here',
                    textStyle: GoogleFonts.lato(
                      color: const Color(0xffab7573),
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  Container(
                    child: TextWidget(
                      hint: '@pixher.app',
                      textStyle: GoogleFonts.lato(
                        color: const Color(0xffe0948f),
                        fontSize: 12,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                    ),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
            ],
          ),
        );
      }
    case 228:
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
                  TextWidget(
                    hint: 'Diwali',
                    textStyle: GoogleFonts.greatVibes(
                      color: const Color(0xffffaf00),
                      fontSize: 48,
                      fontWeight: FontWeight.w700,
                    ),
                    edgeInsetsGeometry: EdgeInsets.zero,
                  ),
                  TextWidget(
                    hint: 'BIG SALE',
                    textStyle: GoogleFonts.lato(
                        color: const Color(0xffffffff),
                        fontSize: 18,
                        letterSpacing: 1.2),
                    edgeInsetsGeometry: EdgeInsets.zero,
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 60,
                      right: 60,
                    ),
                    child: TextWidget(
                      hint:
                          'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.',
                      textStyle: GoogleFonts.lato(
                        color: const Color(0x9fffffff),
                        fontSize: 12,
                      ),
                    ),
                  ),
                  TextWidget(
                    hint: 'www.pixher.app',
                    textStyle: GoogleFonts.lato(
                      color: const Color(0xffffaf00),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 140,
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
              ),
              Positioned(
                child: SizedBox(
                  child: Container(
                    child: TextWidget(
                      hint: 'UP TO 80% OFF',
                      textStyle: GoogleFonts.lato(
                          color: const Color(0xff72040e),
                          fontSize: 16,
                          letterSpacing: 1.2),
                      edgeInsetsGeometry: EdgeInsets.zero,
                    ),
                    //width: MediaQuery.of(context).size.width - 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: const Color(0xffffaf00),
                        borderRadius: BorderRadius.circular(15)),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 100,
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                ),
                bottom: 275,
              )
            ],
          ),
        );
      }
    case 232:
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
                    height: 30,
                  ),
                  ClipRRect(
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: ImageWidget(
                        height: 100,
                        width: 100,
                      ),
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 120,
                      right: 120,
                    ),
                    child: TextWidget(
                      hint:
                          'Wishing you happiness and joy. This festive season get up to 80% off on each brand',
                      textStyle: GoogleFonts.lato(
                        color: const Color(0xffffe8b3),
                        fontSize: 12,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }
    case 237:
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
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    ClipRRect(
                      child: SizedBox(
                        width: 170,
                        height: 350,
                        child: ImageWidget(
                          width: 170,
                          height: 350,
                        ),
                      ),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(100),
                          topRight: Radius.circular(100)),
                    ),
                  ],
                ),
                bottom: 20,
                left: 20,
              ),
              Positioned(
                child: Column(
                  children: [
                    TextWidget(
                      hint: 'BIGGEST FESTIVAL SALE',
                      textStyle: GoogleFonts.lato(
                          color: const Color(0xffff7156),
                          fontSize: 24,
                          height: 1.2,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w700),
                      edgeInsetsGeometry: EdgeInsets.zero,
                    ),
                    TextWidget(
                      hint: '80%',
                      textStyle: GoogleFonts.oswald(
                          color: const Color(0xffff7156),
                          fontSize: 50,
                          fontWeight: FontWeight.w700),
                      edgeInsetsGeometry: EdgeInsets.zero,
                    ),
                    TextWidget(
                      hint: 'OFF ON ENTIRE STORE',
                      textStyle: GoogleFonts.lato(
                          color: const Color(0xffff7156),
                          fontSize: 14,
                          height: 1.1,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w700),
                      edgeInsetsGeometry: EdgeInsets.zero,
                    ),
                  ],
                ),
                right: 20,
                bottom: 100,
                left: MediaQuery.of(context).size.width / 2,
              ),
              Positioned(
                child: TextWidget(
                  hint: 'www.pixher.app',
                  textStyle: GoogleFonts.lato(
                      color: Colors.black45,
                      fontSize: 12,
                      height: 1.1,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w700),
                  edgeInsetsGeometry: EdgeInsets.zero,
                ),
                right: 20,
                bottom: 20,
                left: (MediaQuery.of(context).size.width / 2) + 10,
              ),
            ],
          ),
        );
      }
    case 288:
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextWidget(
                    textStyle: GoogleFonts.ebGaramond(
                      color: const Color(0xff9f7f43),
                      fontSize: 18,
                    ),
                    hint: 'YOU ARE',
                    edgeInsetsGeometry: EdgeInsets.zero,
                  ),
                  TextWidget(
                    textStyle: GoogleFonts.ebGaramond(
                      color: const Color(0xff9f7f43),
                      fontSize: 26,
                    ),
                    edgeInsetsGeometry: EdgeInsets.zero,
                    hint: 'INVITED',
                  ),
                  TextWidget(
                    textStyle: GoogleFonts.greatVibes(
                      color: const Color(0xff182e4e),
                      fontSize: 80,
                    ),
                    edgeInsetsGeometry: EdgeInsets.zero,
                    hint: 'Birthday',
                  ),
                  TextWidget(
                    textStyle: GoogleFonts.greatVibes(
                      color: const Color(0xff182e4e),
                      fontSize: 45,
                    ),
                    edgeInsetsGeometry: EdgeInsets.zero,
                    hint: 'Party',
                  ),
                  TextWidget(
                    textStyle: GoogleFonts.ebGaramond(
                      color: const Color(0xff182e4e),
                      fontSize: 20,
                    ),
                    edgeInsetsGeometry: EdgeInsets.zero,
                    hint: 'SATURDAY | AUGUST 17',
                  ),
                  TextWidget(
                    textStyle: GoogleFonts.ebGaramond(
                      color: const Color(0xff9f7f43),
                      fontSize: 16,
                    ),
                    edgeInsetsGeometry: EdgeInsets.zero,
                    hint: 'START FROM 6PM',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextWidget(
                    textStyle: GoogleFonts.ebGaramond(
                      color: const Color(0xff182e4e),
                      fontSize: 20,
                    ),
                    edgeInsetsGeometry: EdgeInsets.zero,
                    hint: 'PLACE OF CELEBRATION',
                  ),
                  TextWidget(
                    textStyle: GoogleFonts.ebGaramond(
                      color: const Color(0xff9f7f43),
                      fontSize: 14,
                    ),
                    edgeInsetsGeometry: EdgeInsets.zero,
                    hint: 'STREET NAME',
                  ),
                  TextWidget(
                    textStyle: GoogleFonts.ebGaramond(
                      color: const Color(0xff9f7f43),
                      fontSize: 16,
                    ),
                    edgeInsetsGeometry: EdgeInsets.zero,
                    hint: 'CITY NAME, STATE, COUNTRY',
                  ),
                ],
              ),
            ],
          ),
        );
      }
    case 293:
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
                child: TextWidget(
                  textStyle: GoogleFonts.ebGaramond(
                    color: const Color(0xff4d260e),
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  hint: 'Happy Birthday\nDarling!',
                  edgeInsetsGeometry: EdgeInsets.zero,
                  textAlign: TextAlign.start,
                ),
                left: 50,
                top: 50,
              ),
              Positioned(
                child: SizedBox(
                  width: 282,
                  height: 371,
                  child: ImageWidget(
                      /*width: 170,
                    height: 350,*/
                      ),
                ),
                left: 54,
                top: 145,
              ),
              Positioned(
                child: TextWidget(
                  textStyle: GoogleFonts.dancingScript(
                    color: const Color(0xff4d260e),
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  hint: 'I love you...',
                  edgeInsetsGeometry: EdgeInsets.zero,
                  textAlign: TextAlign.start,
                ),
                right: 50,
                bottom: 140,
              )
            ],
          ),
        );
      }
    case 298:
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
                  TextWidget(
                    textStyle: GoogleFonts.ebGaramond(
                      color: const Color(0xffba8368),
                      fontSize: 16,
                    ),
                    edgeInsetsGeometry: EdgeInsets.zero,
                    hint: 'UP TO',
                  ),
                  Row(
                    children: [
                      TextWidget(
                        textStyle: GoogleFonts.merriweather(
                          color: const Color(0xffba8368),
                          fontSize: 96,
                        ),
                        edgeInsetsGeometry: EdgeInsets.zero,
                        hint: '50',
                      ),
                      Column(
                        children: [
                          Text(
                            '%',
                            style: GoogleFonts.merriweather(
                              color: const Color(0xffba8368),
                              fontSize: 36,
                            ),
                          ),
                          Text(
                            'OFF',
                            style: GoogleFonts.merriweather(
                              color: const Color(0xffba8368),
                              fontSize: 20,
                            ),
                          ),
                        ],
                      )
                    ],
                    mainAxisSize: MainAxisSize.min,
                  ),
                  Text(
                    'Sale',
                    style: GoogleFonts.qwitcherGrypen(
                      color: const Color(0xff000000),
                      fontSize: 76,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      height: 40,
                      child: Text(
                        'SHOP NOW',
                        style: GoogleFonts.merriweather(
                          color: const Color(0xffffffff),
                          fontSize: 18,
                        ),
                      ),
                      color: const Color(0xffba8368),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 50,),
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    height: 40,
                    child: Text(
                      'CODE : PIXHER50',
                      style: GoogleFonts.merriweather(
                        color: const Color(0xffba8368),
                        fontSize: 18,
                      ),
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffba8368))),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
            ],
          ),
        );
      }
    default:
      {
        return _updateWidget(context, contentAvailable);
      }
  }
}

Widget _updateWidget(
    BuildContext context, ValueChanged<bool> contentAvailable) {
  contentAvailable(false);
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
