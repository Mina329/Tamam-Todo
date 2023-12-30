import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/core/widgets/custom_simple_appbar.dart';
import 'package:todo/core/widgets/custom_sliver_sizedbox.dart';
import 'package:todo/core/utils/functions/enums.dart';
import 'package:todo/features/calendar/presentation/view/widgets/calendar.dart';
import 'package:todo/features/calendar/presentation/view/widgets/day_choices_buttons.dart';
import 'package:todo/features/index/presentation/view/index%20view/widgets/task_item.dart';

class CalendarViewBody extends StatelessWidget {
  const CalendarViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverSizedBox(
          height: 56.h,
        ),
        SliverToBoxAdapter(
          child: CustomSimpleAppBar(
            title: StringsManager.calendar.tr(),
          ),
        ),
        SliverSizedBox(
          height: 16.h,
        ),
        const SliverToBoxAdapter(
          child: Calendar(),
        ),
        SliverSizedBox(
          height: 20.h,
        ),
        const SliverToBoxAdapter(
          child: DayChoicesButtons(),
        ),
        SliverSizedBox(
          height: 8.h,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 24),
              child: const TaskItem(
                taskState: TaskState.active,
              ),
            ),
            childCount: 4,
          ),
        ),
        SliverSizedBox(
          height: 30.h,
        ),
      ],
    );
  }
}
