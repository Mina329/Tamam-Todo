import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/core/widgets/custom_icons/custom_icons_icons.dart';

class ApplicationItem extends StatelessWidget {
  const ApplicationItem(
      {super.key, required this.appName, required this.hours});
  final String appName;
  final String hours;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white.withOpacity(0.21)
            : Colors.grey[200],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appName,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(
                  height: 5.h,
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    '${StringsManager.youSpent.tr()}$hours${StringsManager.on.tr()}$appName ${StringsManager.today.tr()}',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Icon(
            CustomIcons.info_icon,
            size: 30.sp,
            color: Theme.of(context).brightness == Brightness.dark
                ? null
                : Colors.grey[700],
          )
        ],
      ),
    );
  }
}
