import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color mainColor = Color(0xffd35400);
  static const Color whiteColor = Colors.white;
  static const Color blackColor = Color(0xFF000000);
  static const Color greyColor = Color(0xFF686868);
  static const Color blueColor = Color(0xFF3FA9F8);
  static const Color semiBlack = Colors.black87;
  static const Color fabColor = Colors.blueAccent;


//  static const Color blueColor = Color(0xFF);
}

const txtHeadingNormal = TextStyle(
    //Used for Credits Page
    fontSize: 18,
    letterSpacing: 1,
    fontWeight: FontWeight.bold);

const txtDateNormal = TextStyle(
    //Used for Credits Page
    fontSize: 25,
    letterSpacing: 1,
    fontWeight: FontWeight.w400);

const txtNormal =
    TextStyle(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 1);

const txtCreditsTitle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w600,
);
const txtCreditsSubTitle = TextStyle(
    fontSize: 14, fontWeight: FontWeight.w400, color: Colors.blueGrey);

const txtMainTitle =
    TextStyle(fontSize: 25, fontWeight: FontWeight.w400, letterSpacing: 1, color: AppTheme.whiteColor);

//===========================Test Success ========================//
//class ColorValue{
//  ColorValue._();
//
//  static const Color white= Colors.white;
//}

//===========================Test Success ========================//
