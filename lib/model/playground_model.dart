import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

import '../widget/image_widget.dart';
import '../widget/text_widget.dart';

class Playground {
  bool animated;
  AnimationController? animationController;
  Animation<double>? animation;

  Playground({
    this.animationController,
    this.animated = false,
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
            animation: anim,
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
            animation: anim,
            animationController: controller,
          );
        }
      default:
        {
          return Playground();
        }
    }
  }
}

Widget playgroundWidget(BuildContext context, int templateId,
    {double value = 0.0, String? assetUrl}) {
  switch (templateId) {
    case 42:
      {
        return Container(
          color: Colors.white,
          child: ImageWidget(),
          padding: EdgeInsets.all(value),
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
                  padding: EdgeInsets.only(bottom: (1 - value) * 100),
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
                  child: PhysicalModel(
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 10, left: 10, right: 10, bottom: 25),
                      child: ImageWidget(),
                    ),
                    color: Colors.white,
                    elevation: 8,
                  ),
                  margin: const EdgeInsets.only(
                      top: 30, left: 30, right: 30, bottom: 15),
                ),
                flex: 1,
              ),
              Expanded(
                child: Container(
                  child: PhysicalModel(
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 10, left: 10, right: 10, bottom: 25),
                      child: ImageWidget(),
                    ),
                    color: Colors.white,
                    elevation: 8,
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
    default:
      {
        return Container();
      }
  }
}
