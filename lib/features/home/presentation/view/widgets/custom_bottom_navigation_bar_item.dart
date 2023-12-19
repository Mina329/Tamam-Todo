import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo/core/utils/color_manager.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/core/widgets/custom_icons/custom_icons_icons.dart';

class CustomBottomNavigationBarItem extends StatelessWidget {
  const CustomBottomNavigationBarItem({
    Key? key,
    required this.index,
    required this.isActive,
  }) : super(key: key);
  final List<IconData> inactiveIconList = const [
    CustomIcons.inactive_index_icon,
    CustomIcons.inactive_calendar_icon,
    CustomIcons.inactive_focus_icon,
    CustomIcons.inactive_profile_icon,
  ];
  final List<IconData> activeIconList = const [
    CustomIcons.active_index_icon,
    CustomIcons.active_calendar_icon,
    CustomIcons.active_focus_icon,
    FontAwesomeIcons.solidUser,
  ];
  final List<String> labelList = const [
    StringsManager.index,
    StringsManager.calendar,
    StringsManager.focus,
    StringsManager.profile,
  ];
  final int index;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        isActive
            ? Icon(
                activeIconList[index],
                size: 24,
                color: isActive
                    ? Theme.of(context).brightness == Brightness.dark
                        ? ColorManager.primaryColor
                        : Colors.white
                    : Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black54,
              )
            : Icon(
                inactiveIconList[index],
                size: 24,
                color: isActive
                    ? Theme.of(context).brightness == Brightness.dark
                        ? ColorManager.primaryColor
                        : Colors.white
                    : Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black54,
              ),
        SizedBox(height: 4.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            labelList[index],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: isActive
                      ? Theme.of(context).brightness == Brightness.dark
                          ? ColorManager.primaryColor
                          : Colors.white
                      : Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black54,
                ),
          ),
        ),
      ],
    );
  }
}
