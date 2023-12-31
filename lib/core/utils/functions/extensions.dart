import 'package:flutter/material.dart';

extension ColorExtension on Color {
  String toHex() => '#${value.toRadixString(16)}';
}

extension StringExtension on String {
  Color toColor() => Color(int.parse(substring(1, 7), radix: 16) + 0xFF000000);
}
