import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/core/utils/assets_manager.dart';
import 'package:todo/core/utils/color_manager.dart';

class TaskPriorityItem extends StatelessWidget {
  const TaskPriorityItem({
    Key? key,
    this.onTap,
    required this.index,
    required this.selected,
  }) : super(key: key);
  final Function()? onTap;
  final String index;
  final bool selected;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(5),
      child: Container(
        width: 50.w,
        height: 50.w,
        decoration: BoxDecoration(
          color: selected
              ? ColorManager.primaryColor
              : Theme.of(context).brightness == Brightness.dark
                  ? ColorManager.disabeledColor
                  : Colors.grey[100],
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AssetsManager.flagIcon,
              width: 24.w,
              height: 24.h,
              colorFilter: ColorFilter.mode(
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : selected
                        ? Colors.white
                        : Colors.black,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              index,
              style: Theme.of(context).brightness == Brightness.dark
                  ? Theme.of(context).textTheme.headlineSmall
                  : selected
                      ? Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: Colors.white)
                      : Theme.of(context).textTheme.headlineSmall,
            )
          ],
        ),
      ),
    );
  }
}
