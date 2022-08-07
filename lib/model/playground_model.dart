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
    default:
      {
        return Container();
      }
  }
}
