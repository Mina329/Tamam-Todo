import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/utils/strings_manager.dart';

class TaskPriorityActionButtons extends StatelessWidget {
  const TaskPriorityActionButtons({
    super.key,
    this.cancelOnPressed,
    this.saveOnPressed,
  });
  final Function()? cancelOnPressed;
  final Function()? saveOnPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: cancelOnPressed,
          child: Text(
            StringsManager.cancel,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        SizedBox(width: 8.w),
        ElevatedButton(
          onPressed: saveOnPressed,
          child: Text(
            StringsManager.save,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
