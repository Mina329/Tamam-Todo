import 'package:flutter/material.dart';
import 'package:todo/core/utils/color_manager.dart';
import 'package:todo/core/utils/styles_manager.dart';

abstract class ThemeManager {
  static ThemeData get lightThemeData => ThemeData.light().copyWith(
        scaffoldBackgroundColor: ColorManager.scaffoldColorLight,
        ////////////////// TEXT THEME ////////////////
        textTheme: TextTheme(
          displayLarge: StylesManager.displayLargeLight,
        ),
      );
  static ThemeData get darkThemeData => ThemeData.dark().copyWith(
        scaffoldBackgroundColor: ColorManager.scaffoldColorDark,
        ////////////////// TEXT THEME ////////////////
        textTheme: TextTheme(
          displayLarge: StylesManager.displayLargeDark,
        ),
      );
}
