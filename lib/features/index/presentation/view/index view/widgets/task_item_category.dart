import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/widgets/custom_icons/custom_icons_icons.dart';
import 'package:todo/core/utils/functions/blend_colors.dart';

class TaskItemCategory extends StatelessWidget {
  const TaskItemCategory(
      {super.key, required this.color, required this.categoryName});
  final Color color;
  final String categoryName;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 9.w),
      height: 29.h,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Icon(
            CustomIcons.music_icon,
            size: 15.sp,
            color: blendColors(color, Colors.black),
          ),
          SizedBox(
            width: 5.w,
          ),
          Text(
            categoryName,
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
