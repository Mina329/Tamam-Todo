import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/utils/color_manager.dart';
import 'package:todo/core/utils/strings_manager.dart';

class SaveCancelActionButtons extends StatelessWidget {
  const SaveCancelActionButtons({
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
        InkWell(
          onTap: cancelOnPressed,
          borderRadius: BorderRadius.circular(5),
          child: Container(
            height: 40.h,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              shape: BoxShape.rectangle,
            ),
            child: Center(
              child: Text(
                StringsManager.cancel.tr(),
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: ColorManager.primaryColor),
              ),
            ),
          ),
        ),
        SizedBox(width: 8.w),
        ElevatedButton(
          onPressed: saveOnPressed,
          child: Text(
            StringsManager.save.tr(),
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
