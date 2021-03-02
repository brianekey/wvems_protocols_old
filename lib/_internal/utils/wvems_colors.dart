import 'package:flutter/material.dart';

// TODO(brianekey): maybe load this from an online XML file or something...
// In general, all app colors should be near black or near white, with just
// one accent color that is linked to the year being displayed. The year
// accent color will be chosen to maintain a 7+ to 1 contrast with near
// black (#0F0F0F)

const Map<int, Color> wvemsMap = {
  2021: Color.fromRGBO(255, 242, 204, 1.0), //#fff2cc
  2020: Color.fromRGBO(180, 167, 214, 1.0), //#b4a7d6
  2019: Color.fromRGBO(240, 240, 240, 1.0), //#f0f0f0
};

//WVEMS Logo light blue: 0, 160, 214
const wvemsLightBlue = Color.fromRGBO(0, 160, 214, 1.0);
//WVEMS Logo dark blue: 6, 74, 137
const wvemsDarkBlue = Color.fromRGBO(6, 74, 137, 1.0);
//WVEMS orange: 255, 103, 0
const wvemsOrange = Color.fromRGBO(255, 103, 0, 1.0);

//return the color associated with a year
Color wvemsColor(int _year) =>
    wvemsMap.containsKey(_year) ? wvemsMap[_year] : Colors.white;

//return the text string associated with a year
String wvemsText(int _year) => 'Protocols $_year';

//return the year associated with a color (maybe don't need this?)
int wvemsYear(Color _color) => wvemsMap.keys
    .firstWhere((i) => wvemsMap[i] == _color, orElse: () => 1900);
