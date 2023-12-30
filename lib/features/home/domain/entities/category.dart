import 'package:flutter/material.dart';

class CategoryData {
  final String id;
  final String name;
  final IconData iconData;
  final Color color;

  CategoryData(this.id,
      {required this.name, required this.iconData, required this.color});
}
