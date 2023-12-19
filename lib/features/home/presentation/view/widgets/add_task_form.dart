import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/utils/strings_manager.dart';

class AddTaskForm extends StatelessWidget {
  const AddTaskForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          SizedBox(
            height: 43.h,
            child: TextFormField(
              style: Theme.of(context).textTheme.headlineSmall,
              decoration: const InputDecoration(
                label: Text(
                  StringsManager.taskTitle,
                ),
                hintText: StringsManager.taskTitle,
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
              decoration: const InputDecoration(
                label: Text(
                  StringsManager.taskDescription,
                ),
                hintText: StringsManager.taskDescription,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
