import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/core/widgets/custom_icons/custom_icons_icons.dart';

class DeleteTask extends StatelessWidget {
  const DeleteTask({super.key, this.onTap});
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(6),
          child: Container(
            padding: EdgeInsets.only(top: 5.h, bottom: 5.h, right: 5.w),
            child: Row(
              children: [
                const Icon(
                  CustomIcons.trash_icon,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 8.w,
                ),
                Text(
                  StringsManager.deleteTask.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: Colors.red),
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
