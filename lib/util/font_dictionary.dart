

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle getTextStyle({String? font,dynamic fontSize = 14.0, Color color = Colors.black}){
  if(fontSize is! double){
    fontSize = double.parse(fontSize.toString());
  }
  switch(font){
    case 'satisfy' :{
      return GoogleFonts.satisfy(
        fontSize: fontSize,
        color: color,
      );
    }
    case 'ebGaramond' :{
      return GoogleFonts.ebGaramond(
        fontSize: fontSize,
        color: color,
      );
    }
    case 'gideonRoman' :{
      return GoogleFonts.gideonRoman(
        fontSize: fontSize,
        color: color,
      );
    }
    case 'lato' :{
      return GoogleFonts.lato(
        fontSize: fontSize,
        color: color,
      );
    }
    case 'roboto' :{
      return GoogleFonts.roboto(
        fontSize: fontSize,
        color: color,
      );
    }
    case 'merriweather' :{
      return GoogleFonts.merriweather(
        fontSize: fontSize,
        color: color,
      );
    }
    case 'allura' :{
      return GoogleFonts.allura(
        fontSize: fontSize,
        color: color,
      );
    }
    case 'neuton' :{
      return GoogleFonts.neuton(
        fontSize: fontSize,
        color: color,
      );
    }
    case 'poppins' :{
      return GoogleFonts.poppins(
        fontSize: fontSize,
        color: color,
      );
    }
    case 'exo2' :{
      return GoogleFonts.exo2(
        fontSize: fontSize,
        color: color,
      );
    }
    case 'mavenPro' :{
      return GoogleFonts.mavenPro(
        fontSize: fontSize,
        color: color,
      );
    }
    case 'taviraj' :{
      return GoogleFonts.taviraj(
        fontSize: fontSize,
        color: color,
      );
    }
    case 'greatVibes' :{
      return GoogleFonts.greatVibes(
        fontSize: fontSize,
        color: color,
      );
    }
    case 'slabo13px' :{
      return GoogleFonts.slabo13px(
        fontSize: fontSize,
        color: color,
      );
    }
    case 'ooohBaby' :{
      return GoogleFonts.ooohBaby(
        fontSize: fontSize,
        color: color,
      );
    }
    case 'lobsterTwo' :{
      return GoogleFonts.lobsterTwo(
        fontSize: fontSize,
        color: color,
      );
    }
    case 'oswald' :{
      return GoogleFonts.oswald(
        fontSize: fontSize,
        color: color,
      );
    }
    case 'unicaOne' :{
      return GoogleFonts.unicaOne(
        fontSize: fontSize,
        color: color,
      );
    }
    case 'dancingScript' :{
      return GoogleFonts.dancingScript(
        fontSize: fontSize,
        color: color,
      );
    }
    default : {
      return GoogleFonts.openSans(
        fontSize: fontSize,
        color: color,
      );
    }
  }
}