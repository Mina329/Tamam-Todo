import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:todo/core/utils/app_router.dart';
import 'package:todo/features/calendar/presentation/manager/get_tasks_by_calendar_day_cubit/get_tasks_by_calendar_day_cubit.dart';
import 'package:todo/features/home/domain/entities/task.dart';
import 'package:todo/features/index/presentation/manager/change_task_status_cubit/change_task_status_cubit.dart';
import 'package:todo/features/index/presentation/manager/get_tasks_by_day_cubit/get_tasks_by_day_cubit.dart';
import 'package:todo/features/index/presentation/view/index%20view/widgets/task_item_category.dart';
import 'package:todo/features/index/presentation/view/index%20view/widgets/task_item_priority.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({super.key, required this.task});
  final TaskEntity task;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangeTaskStatusCubit, ChangeTaskStatusState>(
      listener: (context, state) {
        if (state is ChangeTaskStatusLoading) {
        } else if (state is ChangeTaskStatusFailure) {
          Fluttertoast.showToast(
            msg: state.errMessage,
            toastLength: Toast.LENGTH_SHORT,
          );
          setState(() {});
        } else if (state is ChangeTaskStatusSuccess) {
          BlocProvider.of<GetTasksByDayCubit>(context).getTaskByDay(null);
          BlocProvider.of<GetTasksByCalendarDayCubit>(context)
              .getTaskByDay(isCompleted: null, day: null);
        }
      },
      child: InkWell(
        onTap: widget.task.status != "pending"
            ? null
            : () {
                GoRouter.of(context).push(
                  AppRouter.kEditTaskView,
                  extra: (
                    widget.task,
                    BlocProvider.of<GetTasksByDayCubit>(context),
                    BlocProvider.of<GetTasksByCalendarDayCubit>(context),
                  ),
                );
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
                checkedWidget: widget.task.status != "uncompleted"
                    ? null
                    : const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                onTap: widget.task.status != "pending"
                    ? null
                    : (p0) {
                        BlocProvider.of<ChangeTaskStatusCubit>(context)
                            .changeTaskStatus('completed', widget.task.id);
                      },
                isChecked: widget.task.status != "pending",
                border: Border.all(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.grey,
                  width: 2.w,
                ),
                size: 30.w,
                uncheckedColor: Colors.transparent,
                disabledColor: widget.task.status == "completed"
                    ? Colors.green
                    : Colors.red,
              ),
              SizedBox(
                width: 16.w,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(
                      flex: 1,
                    ),
                    Text(
                      widget.task.name,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      widget.task.description,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            '${widget.task.utcTime.year}/${widget.task.utcTime.month}/${widget.task.utcTime.day} ${widget.task.utcTime.hour < 10 ? '0${widget.task.utcTime.hour}' : widget.task.utcTime.hour}:${widget.task.utcTime.minute < 10 ? '0${widget.task.utcTime.minute}' : widget.task.utcTime.minute}',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                        const Spacer(),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: TaskItemCategory(
                            category: widget.task.category,
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: TaskItemPriority(
                              priority: '${widget.task.priority}'),
                        ),
                      ],
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
