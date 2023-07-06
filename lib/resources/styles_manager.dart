import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: avoid_classes_with_only_static_members
class StylesManager {
  static TextStyle header4(Color color, double height) =>
      GoogleFonts.sourceSansPro(
          fontWeight: FontWeight.w400,
          fontSize: 34,
          color: color,
          height: height / 34.0,);

  static TextStyle header5(Color color, double height) =>
      GoogleFonts.sourceSansPro(
          fontWeight: FontWeight.w400,
          fontSize: 34,
          color: color,
          height: height / 34.0,);

  static TextStyle header6(Color color, double height) =>
      GoogleFonts.sourceSansPro(
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: color,

          ///try change height, overflow with maxlines
          height: height / 20.0,);

  static TextStyle cuption(Color color, double height) =>
      GoogleFonts.sourceSansPro(
          fontWeight: FontWeight.w600,
          fontSize: 12,
          color: color,
          height: height / 12.0,);

  static TextStyle body1(Color color, double height) =>
      GoogleFonts.sourceSansPro(
          fontWeight: FontWeight.w400,
          fontSize: 18,
          color: color,
          height: height / 18.0,);

  static TextStyle body1bold(Color color, double height) =>
      GoogleFonts.sourceSansPro(
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: color,
          height: height / 18.0,);

  static TextStyle body2(Color color, double height) =>
      GoogleFonts.sourceSansPro(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: color,
          height: height / 14.0,);

  static TextStyle body2bold(Color color, double height) =>
      GoogleFonts.sourceSansPro(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: color,
          height: height / 14.0,);

  static TextStyle segoe(Color color, double height) =>
      GoogleFonts.sourceSansPro(
          fontWeight: FontWeight.w400,
          fontSize: 10,
          color: color,
          height: height / 10.0,);

  static TextStyle subtitle1(Color color, double height) =>
      GoogleFonts.sourceSansPro(
          fontWeight: FontWeight.w400,
          fontSize: 16,
          color: color,
          height: height / 16.0,);

  static TextStyle body(Color color, double height) =>
      GoogleFonts.sourceSansPro(
          fontWeight: FontWeight.w400,
          fontSize: 16,
          color: color,
          height: height / 16.0,);

  static TextStyle subtitleRegular(Color color, double height) =>
      GoogleFonts.sourceSansPro(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: color,
          height: height / 16.0,);

  static TextStyle regular(Color color, double height) =>
      GoogleFonts.sourceSansPro(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: color,
          height: height / 14.0,);

  static TextStyle subtitle2(Color color, double height) =>
      GoogleFonts.sourceSansPro(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: color,
          height: height / 14.0,);

  static TextStyle subtitle2Roboto(Color color, double height) =>
      GoogleFonts.sourceSansPro(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: color,
        height: height / 14.0,
      );

  static TextStyle overline(Color color, double height) =>
      GoogleFonts.sourceSansPro(
          fontWeight: FontWeight.w300,
          fontSize: 10,
          color: color,
          height: height / 10.0,);

  static TextStyle overline2(Color color, double height) =>
      GoogleFonts.sourceSansPro(
          fontWeight: FontWeight.w600,
          fontSize: 10,
          color: color,
          height: height / 10.0,);
}
