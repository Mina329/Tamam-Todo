import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:todo/core/utils/app_router.dart';
import 'package:todo/features/home/domain/entities/task.dart';
import 'package:todo/features/index/presentation/view/index%20view/widgets/task_item_category.dart';
import 'package:todo/features/index/presentation/view/index%20view/widgets/task_item_priority.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.task});
  final TaskEntity task;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: task.status != "pending"
          ? null
          : () {
              GoRouter.of(context).push(AppRouter.kEditTaskView);
            },
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        height: 100.h,
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
              checkedWidget:
                  task.status != "uncompleted" ? null : const Icon(Icons.close),
              onTap: task.status != "pending" ? null : (p0) {},
              isChecked: task.status != "pending" ? true : false,
              border: Border.all(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.grey,
                width: 2.w,
              ),
              size: 30.w,
              uncheckedColor: Colors.transparent,
              disabledColor:
                  task.status == "completed" ? Colors.green : Colors.red,
            ),
            SizedBox(
              width: 16.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(
                  flex: 1,
                ),
                Text(
                  task.name,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  task.description,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const Spacer(
                  flex: 2,
                ),
                SizedBox(
                  width: 250.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${task.utcTime.year}/${task.utcTime.month}/${task.utcTime.day} ${task.utcTime.hour}:${task.utcTime.minute}',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Row(
                        children: [
                          TaskItemCategory(
                            category: task.category,
                          ),
                          SizedBox(
                            width: 13.w,
                          ),
                          TaskItemPriority(priority: '${task.priority}'),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
