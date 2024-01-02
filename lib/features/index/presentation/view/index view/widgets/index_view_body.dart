import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/core/utils/assets_manager.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/core/widgets/custom_loading_animation.dart';
import 'package:todo/core/widgets/custom_sliver_sizedbox.dart';
import 'package:todo/core/widgets/custom_clickable_container.dart';
import 'package:todo/features/index/presentation/manager/get_tasks_by_day_cubit/get_tasks_by_day_cubit.dart';
import 'package:todo/features/index/presentation/view/index%20view/widgets/custom_drop_down.dart';
import 'package:todo/features/index/presentation/view/index%20view/widgets/custom_index_app_bar.dart';
import 'package:todo/features/index/presentation/view/index%20view/widgets/task_item.dart';

class IndexViewBody extends StatelessWidget {
  const IndexViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: BlocBuilder<GetTasksByDayCubit, GetTasksByDayState>(
        builder: (context, state) {
          if (state is GetTasksByDayLoading) {
            return _buildIndexLoadingBody();
          } else if (state is GetTasksByDaySuccess) {
            if (state.completed.isEmpty && state.uncompleted.isEmpty) {
              return buildIndexSuccessEmptyErrorBody(context, false);
            }
            return _buildIndexSuccessBody(state, context);
          } else if (state is GetTasksByDayFailure) {
            return buildIndexSuccessEmptyErrorBody(context, true);
          }
          return Container();
        },
      ),
    );
  }

  CustomScrollView _buildIndexLoadingBody() {
    return CustomScrollView(
      slivers: [
        SliverSizedBox(
          height: 56.h,
        ),
        const SliverToBoxAdapter(
          child: CustomIndexAppBar(isFilterActive: false),
        ),
        SliverSizedBox(
          height: 15.h,
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: CustomCircularIndicator(
              height: 200.h,
              width: 200.w,
            ),
          ),
        ),
      ],
    );
  }

  CustomScrollView buildIndexSuccessEmptyErrorBody(
      BuildContext context, bool isError) {
    return CustomScrollView(
      slivers: [
        SliverSizedBox(
          height: 56.h,
        ),
        const SliverToBoxAdapter(
          child: CustomIndexAppBar(isFilterActive: false),
        ),
        SliverSizedBox(
          height: 15.h,
        ),
        SliverToBoxAdapter(
          child: CustomDrobDown(
            selectedValue:
                BlocProvider.of<GetTasksByDayCubit>(context).storedDate!.day ==
                        DateTime.now().day
                    ? StringsManager.today.tr()
                    : BlocProvider.of<GetTasksByDayCubit>(context)
                                .storedDate!
                                .day ==
                            DateTime.now().day - 1
                        ? StringsManager.yesterday.tr()
                        : StringsManager.tomorrow.tr(),
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                isError ? AssetsManager.error : AssetsManager.checklist,
                width: 200.w,
                height: 200.h,
              ),
              Text(
                isError
                    ? StringsManager.operationNotAllowed.tr()
                    : StringsManager.tapPlusToAddSomeTasks.tr(),
                style: Theme.of(context).textTheme.headlineSmall,
              )
            ],
          ),
        ),
      ],
    );
  }

  CustomScrollView _buildIndexSuccessBody(
      GetTasksByDaySuccess state, BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverSizedBox(
          height: 56.h,
        ),
        SliverToBoxAdapter(
          child: CustomIndexAppBar(
            isFilterActive:
                state.completed.isNotEmpty || state.uncompleted.isNotEmpty,
            completed: state.completed,
            uncompleted: state.uncompleted,
          ),
        ),
        SliverSizedBox(
          height: 15.h,
        ),
        SliverToBoxAdapter(
          child: CustomDrobDown(
            selectedValue:
                BlocProvider.of<GetTasksByDayCubit>(context).storedDate!.day ==
                        DateTime.now().day
                    ? StringsManager.today.tr()
                    : BlocProvider.of<GetTasksByDayCubit>(context)
                                .storedDate!
                                .day ==
                            DateTime.now().day - 1
                        ? StringsManager.yesterday.tr()
                        : StringsManager.tomorrow.tr(),
          ),
        ),
        SliverSizedBox(
          height: 20.h,
        ),
        if (state.uncompleted.isNotEmpty)
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: TaskItem(
                  task: state.uncompleted[index],
                ),
              ),
              childCount: state.uncompleted.length,
            ),
          ),
        if (state.completed.isNotEmpty && state.uncompleted.isNotEmpty)
          SliverSizedBox(
            height: 20.h,
          ),
        if (state.completed.isNotEmpty)
          SliverToBoxAdapter(
            child: CustomClickableContainer(
              text: StringsManager.completed.tr(),
            ),
          ),
        if (state.completed.isNotEmpty)
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: TaskItem(
                  task: state.completed[index],
                ),
              ),
              childCount: state.completed.length,
            ),
          ),
        SliverSizedBox(
          height: 30.h,
        ),
      ],
    );
  }
}
