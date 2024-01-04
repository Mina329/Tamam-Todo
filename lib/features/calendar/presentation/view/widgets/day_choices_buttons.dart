import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/utils/color_manager.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/features/calendar/presentation/view/widgets/custom_choice_button.dart';

class DayChoicesButtons extends StatefulWidget {
  const DayChoicesButtons({
    super.key,
    required this.isCompleted,
  });
  final Function(bool) isCompleted;
  @override
  State<DayChoicesButtons> createState() => _DayChoicesButtonsState();
}

class _DayChoicesButtonsState extends State<DayChoicesButtons> {
  bool isFinished = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Theme.of(context).brightness == Brightness.dark
              ? ColorManager.greyColor
              : Colors.grey[200],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomChoiceButton(
              isSelected: isFinished,
              text: StringsManager.completed.tr(),
              onTap: () {
                widget.isCompleted(true);
                setState(() {
                  isFinished = !isFinished;
                });
              },
            ),
            SizedBox(
              width: 32.w,
            ),
            CustomChoiceButton(
              isSelected: !isFinished,
              text: StringsManager.uncompleted.tr(),
              onTap: () {
                widget.isCompleted(false);
                setState(() {
                  isFinished = !isFinished;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
