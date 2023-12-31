import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/utils/strings_manager.dart';

class AddTaskForm extends StatelessWidget {
  const AddTaskForm({
    super.key,
    required this.formkey,
  });
  final GlobalKey<FormState> formkey;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Column(
        children: [
          SizedBox(
            height: 43.h,
            child: TextFormField(
              style: Theme.of(context).textTheme.headlineSmall,
              decoration: InputDecoration(
                label: Text(
                  StringsManager.taskTitle.tr(),
                ),
                hintText: StringsManager.taskTitle.tr(),
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          SizedBox(
            height: 43.h,
            child: TextFormField(
              style: Theme.of(context).textTheme.headlineSmall,
              decoration: InputDecoration(
                label: Text(
                  StringsManager.taskDescription.tr(),
                ),
                hintText: StringsManager.taskDescription.tr(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
