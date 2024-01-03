import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/core/widgets/custom_icons/custom_icons_icons.dart';
import 'package:todo/core/widgets/save_cancel_action_buttons.dart';
import 'package:todo/features/home/domain/entities/task.dart';
import 'package:todo/features/home/presentation/view/home%20view/widgets/add_task_form.dart';

class EditTaskNameAndDescription extends StatefulWidget {
  const EditTaskNameAndDescription({
    super.key,
    required this.task,
    required this.onSavedTaskDescription,
    required this.onSavedTaskTitle,
  });
  final TaskEntity task;
  final Function(String?) onSavedTaskDescription;
  final Function(String?) onSavedTaskTitle;
  @override
  State<EditTaskNameAndDescription> createState() =>
      _EditTaskNameAndDescriptionState();
}

class _EditTaskNameAndDescriptionState
    extends State<EditTaskNameAndDescription> {
  String? name;
  String? description;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    name = widget.task.name;
    description = widget.task.description;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name!,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            IconButton(
                onPressed: () {
                  _buildEditTaskTitleAndDescriptionDialog(context);
                },
                icon: const Icon(
                  CustomIcons.edit_icon,
                ))
          ],
        ),
        SizedBox(
          height: 15.h,
        ),
        Text(
          description ?? '',
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Colors.grey[500]),
        )
      ],
    );
  }

  void _buildEditTaskTitleAndDescriptionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                StringsManager.editTitleAndDescription.tr(),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(
                height: 5.h,
              ),
              const Divider(),
              SizedBox(
                height: 5.h,
              ),
              AddTaskForm(
                formkey: formkey,
                intialName: name,
                intialDescription: description,
                onSavedTaskDescription: (p0) {
                  setState(() {
                    description = p0;
                  });
                  widget.onSavedTaskDescription(p0);
                },
                onSavedTaskTitle: (p0) {
                  setState(() {
                    name = p0;
                  });
                  widget.onSavedTaskTitle(p0);
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              SaveCancelActionButtons(
                saveOnPressed: () {
                  if (formkey.currentState!.validate()) {
                    formkey.currentState!.save();
                    GoRouter.of(context).pop();
                  }
                },
                cancelOnPressed: () {
                  GoRouter.of(context).pop();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
