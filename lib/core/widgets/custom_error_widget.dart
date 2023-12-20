import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/core/utils/assets_manager.dart';

class CustomErrorImage extends StatelessWidget {
  const CustomErrorImage({super.key, this.width, this.height});
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AssetsManager.checklist,
      width: width ?? 50.w,
      height: height ?? 50.h,
    );
  }
}
