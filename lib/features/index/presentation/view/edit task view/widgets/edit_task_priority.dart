import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/core/widgets/custom_clickable_container.dart';
import 'package:todo/core/widgets/custom_icons/custom_icons_icons.dart';
import 'package:todo/core/widgets/save_cancel_action_buttons.dart';
import 'package:todo/features/home/presentation/view/widgets/task_priority_item.dart';

class EditTaskPriority extends StatefulWidget {
  const EditTaskPriority({super.key});

  @override
  State<EditTaskPriority> createState() => _EditTaskPriorityState();
}

class _EditTaskPriorityState extends State<EditTaskPriority> {
  int? selectedTaskPriority;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          CustomIcons.flag_icon,
        ),
        SizedBox(
          width: 8.w,
        ),
        Text(
          StringsManager.taskPriority.tr(),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const Spacer(),
        CustomClickableContainer(
          icon: Icon(
            CustomIcons.flag_icon,
            color: Colors.white,
            size: 15.sp,
          ),
          text: '1',
          onTap: () {
            _buildTaskPriorityDialog(context);
          },
        )
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
                    StringsManager.taskPriority.tr(),
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
                  SaveCancelActionButtons(
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
    setState(() {});
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
}
