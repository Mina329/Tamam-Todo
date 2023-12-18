import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/core/utils/color_manager.dart';

class CustomLoginButton extends StatelessWidget {
  const CustomLoginButton({
    super.key,
    required this.asset,
    required this.text,
    this.onPressed,
  });
  final String asset;
  final String text;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          side: const MaterialStatePropertyAll(
            BorderSide(
              color: ColorManager.primaryColor,
            ),
          ),
          backgroundColor: const MaterialStatePropertyAll(
            Colors.transparent,
          ),
          elevation: const MaterialStatePropertyAll(
            0,
          ),
          overlayColor: MaterialStatePropertyAll(
            ColorManager.primaryColor.withAlpha(40),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              asset,
              width: 24.w,
              height: 24.w,
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.headlineSmall,
            )
          ],
        ),
      ),
    );
  }
}
