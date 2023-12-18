// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:todo/core/utils/strings_manager.dart';

class CustomBottomNavigationBarItem extends StatelessWidget {
  const CustomBottomNavigationBarItem({
    Key? key,
    required this.color,
    required this.index,
  }) : super(key: key);
  final List<IconData> iconList = const [
    FontAwesomeIcons.houseChimney,
    FontAwesomeIcons.solidCalendarDays,
    FontAwesomeIcons.solidClock,
    FontAwesomeIcons.solidUser,
  ];
  final List<String> labelList = const [
    StringsManager.index,
    StringsManager.calendar,
    StringsManager.focus,
    StringsManager.profile,
  ];
  final Color color;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          iconList[index],
          size: 24,
          color: color,
        ),
        SizedBox(height: 4.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            labelList[index],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: color,
                ),
          ),
        ),
      ],
    );
  }
}
