import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/core/widgets/custom_icons/custom_icons_icons.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({
    super.key,
    this.onTap,
  });
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(5),
      child: SizedBox(
        height: 48.h,
        child: Row(
          children: [
            const Icon(
              CustomIcons.logout_icon,
              color: Colors.red,
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              StringsManager.logOut.tr(),
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Colors.red),
            )
          ],
        ),
      ),
    );
  }
}
