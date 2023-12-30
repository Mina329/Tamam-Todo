import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/utils/color_manager.dart';
import 'package:todo/core/utils/functions/blend_colors.dart';

class CustomDayWidget extends StatelessWidget {
  const CustomDayWidget({
    super.key,
    required this.weekDay,
    required this.day,
    required this.selected,
  });

  final String weekDay;
  final String day;
  final bool selected;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      padding: EdgeInsets.symmetric(
        vertical: 3.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: selected
            ? ColorManager.primaryColor
            : Theme.of(context).brightness == Brightness.dark
                ? ColorManager.disabeledColor
                : blendColors(ColorManager.primaryColor, Colors.grey[300]!),
      ),
      child: Column(
        children: [
          Text(
            weekDay,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: weekDay == 'SAT' || weekDay == 'SUN'
                      ? selected
                          ? Colors.white
                          : Colors.red
                      : Theme.of(context).brightness == Brightness.dark
                          ? null
                          : selected
                              ? Colors.white
                              : blendColors(
                                  ColorManager.primaryColor,
                                  Colors.black,
                                ),
                ),
          ),
          SizedBox(
            height: 3.h,
          ),
          Text(
            day,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? null
                      : selected
                          ? Colors.white
                          : blendColors(
                              ColorManager.primaryColor,
                              Colors.black,
                            ),
                ),
          ),
        ],
      ),
    );
  }
}
