import 'package:flutter/material.dart';

extension ColorExtension on Color {
  String toHex() => '#${value.toRadixString(16)}';
}

extension StringExtension on String {
  Color toColor() => Color(int.parse(substring(1), radix: 16));
}
