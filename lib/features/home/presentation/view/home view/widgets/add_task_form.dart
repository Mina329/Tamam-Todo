import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/utils/strings_manager.dart';

class AddTaskForm extends StatelessWidget {
  const AddTaskForm({
    super.key,
    required this.formkey,
    required this.onSavedTaskTitle,
    required this.onSavedTaskDescription,
    this.intialName,
    this.intialDescription,
  });
  final GlobalKey<FormState> formkey;
  final String? intialName;
  final String? intialDescription;
  final Function(String?)? onSavedTaskTitle;
  final Function(String?)? onSavedTaskDescription;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Column(
        children: [
          TextFormField(
            style: Theme.of(context).textTheme.headlineSmall,
            initialValue: intialName,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(15),
              label: Text(
                StringsManager.taskTitle.tr(),
              ),
              hintText: StringsManager.taskTitle.tr(),
            ),
            validator: (value) {
              if (value == null || value.length < 3) {
                return StringsManager.nameValidation.tr();
              }
              return null;
            },
            onSaved: onSavedTaskTitle,
          ),
          SizedBox(
            height: 10.h,
          ),
          TextFormField(
            style: Theme.of(context).textTheme.headlineSmall,
            initialValue: intialDescription,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(15),
              label: Text(
                StringsManager.taskDescription.tr(),
              ),
              hintText: StringsManager.taskDescription.tr(),
            ),
            onSaved: onSavedTaskDescription,
          ),
        ],
      ),
    );
  }
}
