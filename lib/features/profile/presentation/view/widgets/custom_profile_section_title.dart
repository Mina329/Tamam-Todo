import 'package:flutter/material.dart';

class CustomProfileSectionTitle extends StatelessWidget {
  const CustomProfileSectionTitle({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.labelMedium,
    );
  }
}
