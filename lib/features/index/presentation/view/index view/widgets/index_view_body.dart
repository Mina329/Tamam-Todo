import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/core/widgets/custom_sliver_sizedbox.dart';
import 'package:todo/features/index/presentation/view/index%20view/index_view.dart';
import 'package:todo/core/widgets/custom_clickable_container.dart';
import 'package:todo/features/index/presentation/view/index%20view/widgets/custom_drop_down.dart';
import 'package:todo/features/index/presentation/view/index%20view/widgets/custom_index_app_bar.dart';
import 'package:todo/features/index/presentation/view/index%20view/widgets/custom_search_field.dart';
import 'package:todo/features/index/presentation/view/index%20view/widgets/task_item.dart';

class IndexViewBody extends StatelessWidget {
  const IndexViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverSizedBox(
            height: 56.h,
          ),
          const SliverToBoxAdapter(
            child: CustomIndexAppBar(),
          ),
          SliverSizedBox(
            height: 15.h,
          ),
          const SliverToBoxAdapter(
            child: CustomSearchField(),
          ),
          SliverSizedBox(
            height: 30.h,
          ),
          SliverToBoxAdapter(
            child: CustomDrobDown(
              values: const [
                'today',
                'tomorrow',
                'yesterday',
              ],
              titles: const [
                StringsManager.today,
                StringsManager.tomorrow,
                StringsManager.yesterday,
              ],
              onSelected: (p0) {
                log(p0);
              },
            ),
          ),
          SliverSizedBox(
            height: 20.h,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: const TaskItem(
                  taskState: TaskState.active,
                ),
              ),
              childCount: 4,
            ),
          ),
          SliverSizedBox(
            height: 20.h,
          ),
          const SliverToBoxAdapter(
            child: CustomClickableContainer(
              text: StringsManager.completed,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: const TaskItem(taskState: TaskState.completed),
              ),
              childCount: 2,
            ),
          ),
          SliverSizedBox(
            height: 30.h,
          ),
        ],
      ),
    );
  }
}
