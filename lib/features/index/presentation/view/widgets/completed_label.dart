import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/utils/strings_manager.dart';

class CompletedLabel extends StatelessWidget {
  const CompletedLabel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
          child: Center(
            child: Text(
              StringsManager.completed,
              style: Theme.of(context).brightness == Brightness.dark
                  ? Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: Colors.white,
                      )
                  : Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: Colors.black,
                      ),
            ),
          ),
        ),
      ],
    );
  }
}
