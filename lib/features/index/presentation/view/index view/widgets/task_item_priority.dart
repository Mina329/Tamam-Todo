import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/utils/color_manager.dart';
import 'package:todo/core/widgets/custom_icons/custom_icons_icons.dart';

class TaskItemPriority extends StatelessWidget {
  const TaskItemPriority({
    super.key,
    required this.priority,
  });
  final String priority;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 29.h,
      width: 50.w,
      padding: EdgeInsets.symmetric(horizontal: 9.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: ColorManager.primaryColor, width: 2.w),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          children: [
            Icon(
              CustomIcons.flag_icon,
              size: 15.sp,
            ),
            SizedBox(
              width: 5.w,
            ),
            Text(
              priority,
              style: Theme.of(context).brightness == Brightness.dark
                  ? Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(color: Colors.white)
                  : Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
