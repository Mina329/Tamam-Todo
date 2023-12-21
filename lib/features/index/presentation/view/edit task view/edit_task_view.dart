import 'package:flutter/material.dart';
import 'package:todo/features/index/presentation/view/edit%20task%20view/widgets/edit_task_view_body.dart';

class EditTaskView extends StatelessWidget {
  const EditTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: EditTaskViewBody(),
    );
  }
}
