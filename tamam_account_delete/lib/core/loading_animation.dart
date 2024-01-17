import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomLoadingAnimation extends StatelessWidget {
  const CustomLoadingAnimation({super.key});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Lottie.asset(
        'assets/loading.json',
        width: MediaQuery.of(context).size.width * 0.05,
        height: MediaQuery.of(context).size.height * 0.2,
      ),
    );
  }

  static buildLoadingIndicator(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const CustomLoadingAnimation();
      },
    );
  }
}
