import 'package:flutter/material.dart';

Color getBlack() {
  return const Color(0xFF17181D);
}

Color getWhite() {
  return const Color(0xFFFAFAFA);
}

Color getGray() {
  return const Color(0xFFCFCFCF);
}

Color getMainRed() {
  return const Color(0xFFF37878);
}

Color getSubRed() {
  return const Color(0xFFFFBEBE);
}

Color getMainOrange() {
  return const Color(0xFFF8BB54);
}

Color getSubOrange() {
  return const Color(0xFFFAD9A1);
}

Color getMainGreen() {
  return const Color(0xFF96E263);
}

Color getSubGreen() {
  return const Color(0xFFD9F8C4);
}

Color getMainYellow() {
  return const Color(0xFFFFE924);
}

Color getSubYellow() {
  return const Color(0xFFFCFF79);
}

List<int> colorPaletteIndices = [
  50,
  100,
  200,
  300,
  400,
  500,
  600,
  700,
  800,
  900
];

MaterialColor getMaterialColor(Color color) {
  final int red = color.red, green = color.green, blue = color.blue;

  final Map<int, Color> shades = {
    50: Color.fromRGBO(red, green, blue, .1),
    100: Color.fromRGBO(red, green, blue, .2),
    200: Color.fromRGBO(red, green, blue, .3),
    300: Color.fromRGBO(red, green, blue, .4),
    400: Color.fromRGBO(red, green, blue, .5),
    500: Color.fromRGBO(red, green, blue, .6),
    600: Color.fromRGBO(red, green, blue, .7),
    700: Color.fromRGBO(red, green, blue, .8),
    800: Color.fromRGBO(red, green, blue, .9),
    900: Color.fromRGBO(red, green, blue, 1),
  };

  return MaterialColor(color.value, shades);
}

enum MemoColor {
  red(1, Color(0xFFF37878), Color(0xFFFFBEBE)),
  orange(2, Color(0xFFF8BB54), Color(0xFFFAD9A1)),
  yellow(3, Color(0xFF96E263), Color(0xFFD9F8C4)),
  green(4, Color(0xFFFFE924), Color(0xFFFCFF79));

  const MemoColor(this.group, this.mainColor, this.subColor);

  final int group;
  final Color mainColor;
  final Color subColor;

  factory MemoColor.getByGroup(int group) {
    return MemoColor.values.firstWhere((element) => element.group == group,
        orElse: () => MemoColor.red);
  }
}
