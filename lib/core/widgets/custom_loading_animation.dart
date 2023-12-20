// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import 'package:todo/core/utils/assets_manager.dart';

class CustomLoadingAnimation extends StatelessWidget {
  const CustomLoadingAnimation({super.key});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Lottie.asset(
        AssetsManager.loading,
        width: 50.w,
        height: 100.h,
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

class CustomCircularIndicator extends StatelessWidget {
  const CustomCircularIndicator({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      AssetsManager.loading,
      width: width ?? 50.w,
      height: height ?? 100.h,
    );
  }
}
