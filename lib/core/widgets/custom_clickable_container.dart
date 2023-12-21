import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomClickableContainer extends StatelessWidget {
  const CustomClickableContainer({
    super.key,
    required this.text,
    this.onTap,
    this.icon,
  });
  final String text;
  final Function()? onTap;
  final Icon? icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            height: 40.h,
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white.withOpacity(0.21)
                  : Colors.grey[200],
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                if (icon != null) icon!,
                if (icon != null)
                  SizedBox(
                    width: 5.w,
                  ),
                Center(
                  child: Text(
                    text,
                    style: Theme.of(context).brightness == Brightness.dark
                        ? Theme.of(context).textTheme.labelSmall!.copyWith(
                              color: Colors.white,
                            )
                        : Theme.of(context).textTheme.labelSmall!.copyWith(
                              color: Colors.black,
                            ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
