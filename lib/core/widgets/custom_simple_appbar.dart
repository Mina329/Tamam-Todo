import 'package:flutter/material.dart';

class CustomSimpleAppBar extends StatelessWidget {
  const CustomSimpleAppBar({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
