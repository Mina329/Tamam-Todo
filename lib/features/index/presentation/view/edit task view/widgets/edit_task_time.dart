import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/core/widgets/custom_clickable_container.dart';
import 'package:todo/core/widgets/custom_icons/custom_icons_icons.dart';

class EditTaskTime extends StatefulWidget {
  const EditTaskTime({
    super.key,
  });

  @override
  State<EditTaskTime> createState() => _EditTaskTimeState();
}

class _EditTaskTimeState extends State<EditTaskTime> {
  DateTime? selectedDate;
  TimeOfDay? selectedTimeOfDay;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          CustomIcons.clock_icon,
        ),
        SizedBox(
          width: 8.w,
        ),
        Text(
          StringsManager.taskTime,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const Spacer(),
        CustomClickableContainer(
          text: 'Today At 16:45',
          onTap: () {
            _showCalendarAndTime(context);
          },
        )
      ],
    );
  }

  Future<void> _showCalendarAndTime(BuildContext context) async {
    selectedDate = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2223),
        confirmText: StringsManager.chooseTime,
        initialDate: DateTime.now());
    if (selectedDate != null && context.mounted) {
      selectedTimeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (selectedTimeOfDay != null) {
        setState(() {});
      } else {
        selectedDate = null;
        selectedTimeOfDay = null;
        setState(() {});
      }
    } else {
      selectedDate = null;
      selectedTimeOfDay = null;
      setState(() {});
    }
  }
}
