import 'dart:ui';

import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      primarySwatch: const MaterialColor(0xffa61651, {
        50: Color.fromRGBO(166, 22, 81, .1),
        100: Color.fromRGBO(166, 22, 81, .2),
        200: Color.fromRGBO(166, 22, 81, .3),
        300: Color.fromRGBO(166, 22, 81, .4),
        400: Color.fromRGBO(166, 22, 81, .5),
        500: Color.fromRGBO(166, 22, 81, .6),
        600: Color.fromRGBO(166, 22, 81, .7),
        700: Color.fromRGBO(166, 22, 81, .8),
        800: Color.fromRGBO(166, 22, 81, .9),
        900: Color.fromRGBO(166, 22, 81, 1),
      }),
      primaryColor: isDarkTheme ? Colors.black : Colors.white,
      backgroundColor: isDarkTheme ? Colors.black : const Color(0xffF1F5FB),
      indicatorColor:
          isDarkTheme ? const Color(0xff0E1D36) : const Color(0xffCBDCF8),
      buttonColor:
          isDarkTheme ? const Color(0xff3B3B3B) : const Color(0xffF1F5FB),
      hintColor:
          isDarkTheme ? const Color(0xff280C0B) : const Color(0xffEECED3),
      highlightColor:
          isDarkTheme ? const Color(0xff372901) : const Color(0xffFCE192),
      hoverColor:
          isDarkTheme ? const Color(0xff3A3A3B) : const Color(0xff4285F4),
      focusColor:
          isDarkTheme ? const Color(0xff0B2512) : const Color(0xffa61651),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xffa61651),
        foregroundColor: Colors.white,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: isDarkTheme ? Colors.black : const Color(0xffF1F5FB),
        elevation: 5,
        selectedItemColor: isDarkTheme ? Colors.white : const Color(0xffa61651),
        unselectedItemColor: Colors.grey.withOpacity(0.8),
      ),
      disabledColor: Colors.grey,
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: isDarkTheme ? Colors.white : Colors.black,
      ),
      cardColor: isDarkTheme ? const Color(0xFF151515) : Colors.white,
      canvasColor: isDarkTheme ? const Color(0xff121212) : Colors.grey[50],
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme
              ? const ColorScheme.dark()
              : const ColorScheme.light()),
      appBarTheme: const AppBarTheme(
        elevation: 0.0,
      ),
      textTheme: Theme.of(context).textTheme.copyWith(
            headline1: Theme.of(context).textTheme.headline1?.copyWith(
                inherit: true,
                fontSize: 34.0,
                color:
                    isDarkTheme ? Colors.white : Colors.black.withOpacity(0.8),
                fontFamily: 'Lato',
                height: 1.3),
            headline2: Theme.of(context).textTheme.headline2?.copyWith(
                inherit: true,
                fontSize: 28.0,
                color:
                    isDarkTheme ? Colors.white : Colors.black.withOpacity(0.8),
                fontFamily: 'Lato',
                height: 1.2),
            headline3: Theme.of(context).textTheme.headline3?.copyWith(
                inherit: true,
                fontSize: 22.0,
                color:
                    isDarkTheme ? Colors.white : Colors.black.withOpacity(0.8),
                fontFamily: 'Lato',
                height: 1.2),
            headline4: Theme.of(context).textTheme.headline4?.copyWith(
                inherit: true,
                fontSize: 18.0,
                color:
                    isDarkTheme ? Colors.white : Colors.black.withOpacity(0.8),
                fontFamily: 'Lato',
                height: 1.2),
            headline5: Theme.of(context).textTheme.headline5?.copyWith(
                inherit: true,
                fontSize: 16.0,
                color: isDarkTheme ? Colors.white : Colors.black,
                fontFamily: 'Lato',
                height: 1.3),
            headline6: Theme.of(context).textTheme.headline6?.copyWith(
                inherit: true,
                fontSize: 14.0,
                color:
                    isDarkTheme ? Colors.white : Colors.black.withOpacity(0.6),
                fontFamily: 'Lato',
                height: 1.2),
            subtitle1: Theme.of(context).textTheme.subtitle1?.copyWith(
                inherit: true,
                fontSize: 12.0,
                color:
                    isDarkTheme ? Colors.white : Colors.black.withOpacity(0.8),
                fontFamily: 'Lato',
                height: 1.4),
            subtitle2: Theme.of(context).textTheme.subtitle2?.copyWith(
                inherit: true,
                fontSize: 14.0,
                color:
                    isDarkTheme ? Colors.white : Colors.black.withOpacity(0.8),
                fontFamily: 'Lato',
                height: 1.4),
            bodyText1: Theme.of(context).textTheme.bodyText1?.copyWith(
                inherit: true,
                fontSize: 13.0,
                color: isDarkTheme ? Colors.white : Colors.black,
                fontFamily: 'Lato',
                height: 1.4),
            bodyText2: Theme.of(context).textTheme.bodyText2?.copyWith(
                inherit: true,
                fontSize: 10.0,
                color: isDarkTheme ? Colors.white : Colors.black,
                fontFamily: 'Lato',
                height: 1.4),
          ),
    );
  }
}
