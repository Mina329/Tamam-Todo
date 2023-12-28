import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/widgets/custom_sliver_sizedbox.dart';
import 'package:todo/features/index/presentation/view/edit%20task%20view/widgets/delete_task.dart';
import 'package:todo/features/index/presentation/view/edit%20task%20view/widgets/edit_task_category.dart';
import 'package:todo/features/index/presentation/view/edit%20task%20view/widgets/edit_task_name_and_description.dart';
import 'package:todo/features/index/presentation/view/edit%20task%20view/widgets/edit_task_priority.dart';
import 'package:todo/features/index/presentation/view/edit%20task%20view/widgets/edit_task_time.dart';
import 'package:todo/features/index/presentation/view/edit%20task%20view/widgets/save_button.dart';

class EditTaskViewBody extends StatelessWidget {
  const EditTaskViewBody({super.key});

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
          const SliverToBoxAdapter(
            child: EditTaskNameAndDescription(),
          ),
          SliverSizedBox(
            height: 35.h,
          ),
          const SliverToBoxAdapter(
            child: EditTaskTime(),
          ),
          SliverSizedBox(
            height: 35.h,
          ),
          const SliverToBoxAdapter(
            child: EditTaskCategory(),
          ),
          SliverSizedBox(
            height: 35.h,
          ),
          const SliverToBoxAdapter(
            child: EditTaskPriority(),
          ),
          SliverSizedBox(
            height: 35.h,
          ),
          SliverToBoxAdapter(
            child: DeleteTask(
              onTap: () {},
            ),
          ),
          const SliverFillRemaining(
            hasScrollBody: false,
            child: SaveButton(),
          ),
        ],
      ),
    );
  }
}
