import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class StylesManager {
  static TextStyle get displayLargeDark => GoogleFonts.lato(
        color: Colors.white,
        fontSize: 40.sp,
        fontWeight: FontWeight.w700,
      );
  static TextStyle get displayLargeLight => GoogleFonts.lato(
        color: Colors.black,
        fontSize: 40.sp,
        fontWeight: FontWeight.w700,
      );
}
