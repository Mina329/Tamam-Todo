import 'package:flutter/material.dart';

Color blendColors(Color color1, Color color2) {
  int blendedRed = (color1.red + color2.red) ~/ 2;
  int blendedGreen = (color1.green + color2.green) ~/ 2;
  int blendedBlue = (color1.blue + color2.blue) ~/ 2;

  int blendedAlpha = color1.alpha;

  return Color.fromARGB(blendedAlpha, blendedRed, blendedGreen, blendedBlue);
}
