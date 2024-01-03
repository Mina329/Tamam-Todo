import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/core/widgets/custom_loading_animation.dart';
import 'package:todo/core/widgets/custom_sliver_sizedbox.dart';
import 'package:todo/features/home/domain/entities/category.dart';
import 'package:todo/features/home/domain/entities/task.dart';
import 'package:todo/features/index/presentation/manager/delete_task_cubit/delete_task_cubit.dart';
import 'package:todo/features/index/presentation/manager/edit_task_cubit/edit_task_cubit.dart';
import 'package:todo/features/index/presentation/manager/get_tasks_by_day_cubit/get_tasks_by_day_cubit.dart';
import 'package:todo/features/index/presentation/view/edit%20task%20view/widgets/delete_task.dart';
import 'package:todo/features/index/presentation/view/edit%20task%20view/widgets/edit_task_category.dart';
import 'package:todo/features/index/presentation/view/edit%20task%20view/widgets/edit_task_name_and_description.dart';
import 'package:todo/features/index/presentation/view/edit%20task%20view/widgets/edit_task_priority.dart';
import 'package:todo/features/index/presentation/view/edit%20task%20view/widgets/edit_task_time.dart';
import 'package:todo/features/index/presentation/view/edit%20task%20view/widgets/save_button.dart';

class EditTaskViewBody extends StatefulWidget {
  const EditTaskViewBody({super.key, required this.task});
  final TaskEntity task;

  @override
  State<EditTaskViewBody> createState() => _EditTaskViewBodyState();
}

class _EditTaskViewBodyState extends State<EditTaskViewBody> {
  late String name;
  late String description;
  late DateTime time;
  late CategoryEntity category;
  late int priority;
  @override
  void initState() {
    super.initState();
    name = widget.task.name;
    description = widget.task.description;
    time = widget.task.utcTime;
    category = widget.task.category;
    priority = widget.task.priority;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverSizedBox(
            height: 55.h,
          ),
          SliverToBoxAdapter(
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    GoRouter.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.close,
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: EditTaskNameAndDescription(
              task: widget.task,
              onSavedTaskTitle: (p0) {
                if (p0 != null) {
                  name = p0;
                }
              },
              onSavedTaskDescription: (p0) {
                description = p0 ?? '';
              },
            ),
          ),
          SliverSizedBox(
            height: 35.h,
          ),
          SliverToBoxAdapter(
            child: EditTaskTime(
              date: widget.task.utcTime,
              onSavedTime: (p0) {
                time = p0;
              },
            ),
          ),
          SliverSizedBox(
            height: 35.h,
          ),
          SliverToBoxAdapter(
            child: EditTaskCategory(
              categoryEntity: widget.task.category,
              onSavedCategory: (p0) {
                category = p0;
              },
            ),
          ),
          SliverSizedBox(
            height: 35.h,
          ),
          SliverToBoxAdapter(
            child: EditTaskPriority(
              intialPriority: widget.task.priority,
              onSavedPriority: (p0) {
                priority = p0;
              },
            ),
          ),
          SliverSizedBox(
            height: 35.h,
          ),
          SliverToBoxAdapter(
            child: BlocListener<DeleteTaskCubit, DeleteTaskState>(
              listener: (context, state) {
                if (state is DeleteTaskLoading) {
                  CustomLoadingAnimation.buildLoadingIndicator(context);
                } else if (state is DeleteTaskFailure) {
                  GoRouter.of(context).pop();
                  Fluttertoast.showToast(
                    msg: state.errMessage,
                    toastLength: Toast.LENGTH_SHORT,
                  );
                } else if (state is DeleteTaskSuccess) {
                  Fluttertoast.showToast(
                    msg: StringsManager.taskDeletedSuccessfully.tr(),
                    toastLength: Toast.LENGTH_SHORT,
                  );
                  BlocProvider.of<GetTasksByDayCubit>(context)
                      .getTaskByDay(null);
                  GoRouter.of(context).pop();
                  GoRouter.of(context).pop();
                }
              },
              child: DeleteTask(
                onTap: () {
                  BlocProvider.of<DeleteTaskCubit>(context)
                      .deleteTask(widget.task.id);
                },
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: BlocListener<EditTaskCubit, EditTaskState>(
              listener: (context, state) {
                if (state is EditTaskLoading) {
                  CustomLoadingAnimation.buildLoadingIndicator(context);
                } else if (state is EditTaskFailure) {
                  GoRouter.of(context).pop();
                  Fluttertoast.showToast(
                    msg: state.errMessage,
                    toastLength: Toast.LENGTH_SHORT,
                  );
                } else if (state is EditTaskSuccess) {
                  Fluttertoast.showToast(
                    msg: StringsManager.taskEditedSuccessfully.tr(),
                    toastLength: Toast.LENGTH_SHORT,
                  );
                  BlocProvider.of<GetTasksByDayCubit>(context)
                      .getTaskByDay(null);
                  GoRouter.of(context).pop();
                  GoRouter.of(context).pop();
                }
              },
              child: SaveButton(
                onPressed: () {
                  BlocProvider.of<EditTaskCubit>(context).editTask(
                    widget.task,
                    TaskEntity(
                      id: widget.task.id,
                      name: name,
                      description: description,
                      category: category,
                      priority: priority,
                      utcTime: time,
                      status: widget.task.status,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
