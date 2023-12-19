import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/utils/color_manager.dart';
import 'package:todo/core/widgets/functions/blend_colors.dart';
import 'package:vibration/vibration.dart';

class TaskCategoryItem extends StatefulWidget {
  const TaskCategoryItem({
    super.key,
    required this.color,
    required this.title,
    required this.icon,
    required this.selected,
    this.onTap,
  });
  final Color color;
  final String title;
  final IconData icon;
  final bool selected;
  final Function()? onTap;

  @override
  State<TaskCategoryItem> createState() => _TaskCategoryItemState();
}

class _TaskCategoryItemState extends State<TaskCategoryItem> {
  bool isVisableDelete = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            InkWell(
              onTap: widget.onTap,
              onLongPress: () async {
                Vibration.vibrate(duration: 100);

                setState(() {
                  isVisableDelete = !isVisableDelete;
                });
              },
              borderRadius: BorderRadius.circular(4),
              child: Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: widget.selected
                        ? ColorManager.primaryColor
                        : Colors.transparent,
                    width: 2.w,
                  ),
                  color: widget.color,
                ),
                child: Icon(
                  widget.icon,
                  color: blendColors(widget.color, Colors.black),
                ),
              ),
            ),
            Visibility(
              visible: isVisableDelete,
              child: Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    log('Category Deleted');
                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 18.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
        Text(
          widget.title,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ],
    );
  }
}
