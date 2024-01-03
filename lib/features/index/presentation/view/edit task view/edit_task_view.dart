import 'package:flutter/material.dart';
import 'package:todo/features/home/domain/entities/task.dart';
import 'package:todo/features/index/presentation/view/edit%20task%20view/widgets/edit_task_view_body.dart';

class EditTaskView extends StatelessWidget {
  const EditTaskView({super.key, required this.task});
  final TaskEntity task;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EditTaskViewBody(task: task),
    );
  }
}
