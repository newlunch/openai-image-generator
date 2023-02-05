import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';

HexColor backgroundColor = HexColor("#130f1a");
HexColor allElementsColor = HexColor("#171221");
HexColor circularProgressIndinactorColor = HexColor("#1f1930");

TextStyle textStyle(fontSize) {
  return GoogleFonts.roboto(
      fontSize: fontSize, color: Colors.white, fontWeight: FontWeight.w200);
}
