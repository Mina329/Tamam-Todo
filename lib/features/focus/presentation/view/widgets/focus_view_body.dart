import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/core/widgets/custom_simple_appbar.dart';
import 'package:todo/core/widgets/custom_sliver_sizedbox.dart';
import 'package:todo/features/focus/presentation/view/widgets/application_item.dart';
import 'package:todo/features/focus/presentation/view/widgets/counter_timer_widget.dart';
import 'package:todo/features/focus/presentation/view/widgets/overview_section.dart';

class FocusViewBody extends StatelessWidget {
  const FocusViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverSizedBox(
            height: 56.h,
          ),
          SliverToBoxAdapter(
            child: CustomSimpleAppBar(
              title: StringsManager.focus.tr(),
            ),
          ),
          SliverSizedBox(
            height: 56.h,
          ),
          const SliverToBoxAdapter(
            child: CounterTimerWidget(),
          ),
          SliverSizedBox(
            height: 50.h,
          ),
          const SliverToBoxAdapter(
            child: OverviewSection(),
          ),
          SliverSizedBox(
            height: 25.h,
          ),
          SliverToBoxAdapter(
            child: Text(
              StringsManager.applications.tr(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          SliverSizedBox(
            height: 20.h,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: const ApplicationItem(
                  appName: 'Instgram',
                  hours: '5h',
                ),
              ),
              childCount: 5,
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
