import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:todo/core/utils/color_manager.dart';
import 'package:todo/features/index/presentation/view/index_view.dart';
import 'package:todo/features/index/presentation/view/widgets/task_item_category.dart';
import 'package:todo/features/index/presentation/view/widgets/task_item_priority.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.taskState});
  final TaskState taskState;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      height: 80.h,
      width: 327.w,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white.withOpacity(0.21)
            : Colors.grey[200],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RoundCheckBox(
            checkedWidget: taskState != TaskState.uncompleted
                ? null
                : const Icon(Icons.close),
            onTap: taskState != TaskState.active ? null : (p0) {},
            isChecked: taskState == TaskState.completed
                ? true
                : taskState == TaskState.uncompleted
                    ? true
                    : false,
            border: Border.all(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.grey,
              width: 2.w,
            ),
            size: 30.w,
            uncheckedColor: Colors.transparent,
            disabledColor:
                taskState == TaskState.completed ? Colors.green : Colors.red,
          ),
          SizedBox(
            width: 16.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Do Math',
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(
                width: 5.w,
              ),
              SizedBox(
                width: 250.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Today At ${DateTime.now().hour}:${DateTime.now().minute}',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Row(
                      children: [
                        const TaskItemCategory(
                          color: ColorManager.primaryColor,
                          categoryName: 'Music',
                        ),
                        SizedBox(
                          width: 13.w,
                        ),
                        const TaskItemPriority(priority: '2'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
