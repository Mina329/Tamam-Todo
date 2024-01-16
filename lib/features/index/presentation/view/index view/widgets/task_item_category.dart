import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/utils/functions/extensions.dart';
import 'package:todo/core/utils/functions/blend_colors.dart';
import 'package:todo/features/home/domain/entities/category.dart';

class TaskItemCategory extends StatelessWidget {
  const TaskItemCategory({super.key, required this.category});
  final CategoryEntity category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      height: 29.h,
      decoration: BoxDecoration(
        color: category.color.toColor(),
        borderRadius: BorderRadius.circular(6),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          children: [
            Icon(
              category.iconData.toIconData(),
              color: blendColors(category.color.toColor(), Colors.black),
            ),
            SizedBox(
              width: 5.w,
            ),
            SizedBox(
              width: 40.w,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  category.name,
                  maxLines: 1,
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
