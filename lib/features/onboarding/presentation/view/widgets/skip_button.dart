import 'package:flutter/material.dart';

class SkipBackButton extends StatelessWidget {
  const SkipBackButton({
    super.key,
    required this.text,
    this.onPressed,
  });
  final String text;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white.withOpacity(0.4)
                    : Colors.black.withOpacity(0.4),
              ),
        ),
      ),
    );
  }
}
