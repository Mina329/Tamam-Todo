import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/utils/color_manager.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/core/widgets/flag_icon/my_flutter_app_icons.dart';
import 'package:todo/features/home/presentation/view/widgets/task_priority_action_buttons.dart';
import 'package:todo/features/home/presentation/view/widgets/task_priority_item.dart';

class AddTaskActionButtons extends StatefulWidget {
  const AddTaskActionButtons({
    super.key,
  });

  @override
  State<AddTaskActionButtons> createState() => _AddTaskActionButtonsState();
}

class _AddTaskActionButtonsState extends State<AddTaskActionButtons> {
  DateTime? selectedDate;
  TimeOfDay? selectedTimeOfDay;
  int? selectedTaskPriority;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () async {
            await _showCalendarAndTime(context);
          },
          icon: Icon(
            Icons.watch_later_outlined,
            size: 27.sp,
            color: selectedTimeOfDay != null ? ColorManager.primaryColor : null,
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.category_outlined,
            size: 27.sp,
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        IconButton(
          onPressed: () {
            _buildTaskPriorityDialog(context);
          },
          icon: Icon(
            MyFlutterApp.flag_icon,
            size: 27.sp,
            color:
                selectedTaskPriority != null ? ColorManager.primaryColor : null,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.send_rounded,
            size: 27.sp,
            color: ColorManager.primaryColor,
          ),
        ),
      ],
    );
  }

  void _buildTaskPriorityDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) => Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    StringsManager.taskPriority,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  const Divider(),
                  SizedBox(
                    height: 5.h,
                  ),
                  _buildTaskPriorityGridView(setState),
                  SizedBox(height: 16.h),
                  TaskPriorityActionButtons(
                    cancelOnPressed: () {
                      selectedTaskPriority = null;
                      GoRouter.of(context).pop();
                    },
                    saveOnPressed: () {
                      GoRouter.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    if (context.mounted) {
      setState(() {});
    }
  }

  GridView _buildTaskPriorityGridView(StateSetter setState) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return TaskPriorityItem(
          onTap: () {
            selectedTaskPriority = index + 1;
            setState(() {});
          },
          index: (index + 1).toString(),
          selected: selectedTaskPriority == index + 1,
        );
      },
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
      }
    }
  }
}
