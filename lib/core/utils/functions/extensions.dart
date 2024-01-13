import 'package:flutter/material.dart';

extension ColorExtension on Color {
  String toHex() => '#${value.toRadixString(16)}';
}

extension StringExtension on String {
  Color toColor() => Color(int.parse(substring(1), radix: 16));
}

extension IntExtension on int {
  IconData toIconData() => IconData(this, fontFamily: 'MaterialIcons');
}

extension StringIdExtension on String {
  int generateId() {
    List<int> bytes = codeUnits;
    int hash = bytes.fold(0, (result, byte) => 31 * result + byte);
    int id = hash % 10000;
    return id < 0 ? id + 10000 : id;
  }
}
