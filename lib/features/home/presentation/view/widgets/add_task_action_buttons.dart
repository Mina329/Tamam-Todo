import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/utils/color_manager.dart';
import 'package:todo/core/utils/strings_manager.dart';

class AddTaskActionButtons extends StatelessWidget {
  const AddTaskActionButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () async {
            await _showCalendarAndTime(context);
          },
          icon: Icon(
            Icons.watch_later_outlined,
            size: 27.sp,
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.category_outlined,
            size: 27.sp,
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.flag_outlined,
            size: 27.sp,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.send_rounded,
            size: 27.sp,
            color: ColorManager.primaryColor,
          ),
        ),
      ],
    );
  }

  Future<void> _showCalendarAndTime(BuildContext context) async {
    TimeOfDay? time;
    DateTime? selectedDate = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2223),
        confirmText: StringsManager.chooseTime,
        initialDate: DateTime.now());
    if (selectedDate != null && context.mounted) {
      time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
    }
    log('Date: $selectedDate Time: $time');
  }
}
