import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class FlushbarCustom {
  static Future<Flushbar> buildFlushbar(
      {required String title,
        required Color backgroundColor,
        required Color textColor,
        required BuildContext context}) async {
    return Flushbar(
      // message: 'Markets are Currently Closed',
      messageText: Text(
        title,
        // 'Lorem Ipsum is simply dummy text of the printing and typesetting industry',

        style: TextStyle(
            fontSize: 12, color: textColor, fontWeight: FontWeight.w400),
      ),
      duration: Duration(seconds: 4),
      backgroundColor: backgroundColor,
      borderRadius: BorderRadius.circular(52),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      margin:
      EdgeInsets.symmetric(horizontal: 16, vertical: kToolbarHeight + 16),
      mainButton: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Text(
          'Dismiss   ',
          style: TextStyle(
              fontSize: 12, color: textColor, fontWeight: FontWeight.w500),
        ),
      ),
      flushbarPosition: FlushbarPosition.TOP,
      forwardAnimationCurve: Curves.easeIn,
      reverseAnimationCurve: Curves.easeOut,
      // boxShadows: [
      //   BoxShadow(
      //       color: Colors.black.withOpacity(.12),
      //       blurRadius: 20.0, // soften the shadow
      //       spreadRadius: 5.0, //extend the shadow
      //       offset: Offset(
      //           0, // Move to right 10  horizontally
      //           10.0 // Move to bottom 10 Vertically
      //           )),
      // ],
      isDismissible: true,
      dismissDirection: FlushbarDismissDirection.VERTICAL,
    );
  }
}
