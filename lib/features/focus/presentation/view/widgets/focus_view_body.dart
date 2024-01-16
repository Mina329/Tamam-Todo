import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/core/utils/assets_manager.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/core/widgets/custom_loading_animation.dart';
import 'package:todo/core/widgets/custom_simple_appbar.dart';
import 'package:todo/core/widgets/custom_sliver_sizedbox.dart';
import 'package:todo/features/focus/presentation/managers/get_apps_usage_list_cubit/get_apps_usage_list_cubit.dart';
import 'package:todo/features/focus/presentation/view/widgets/application_item.dart';
import 'package:todo/features/focus/presentation/view/widgets/counter_timer_widget.dart';
import 'package:todo/features/focus/presentation/view/widgets/today_focused.dart';

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
            child: TodayFocused(),
          ),
          const SliverToBoxAdapter(
            child: CounterTimerWidget(),
          ),
          SliverSizedBox(
            height: 50.h,
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
          BlocBuilder<GetAppsUsageListCubit, GetAppsUsageListState>(
            builder: (context, state) {
              if (state is GetAppsUsageListLoading) {
                return const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: CustomCircularIndicator(),
                  ),
                );
              } else if (state is GetAppsUsageListFailure) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: SvgPicture.asset(
                          AssetsManager.error,
                          width: 150.w,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        StringsManager.operationNotAllowed.tr(),
                        style: Theme.of(context).textTheme.headlineSmall,
                      )
                    ],
                  ),
                );
              } else if (state is GetAppsUsageListSuccess) {
                if (state.appInfos.isEmpty) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AssetsManager.checklist,
                          width: 200.w,
                          height: 200.h,
                        ),
                        ElevatedButton(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              StringsManager.refresh.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          onPressed: () {
                            BlocProvider.of<GetAppsUsageListCubit>(context)
                                .getAppsUsageList();
                          },
                        ),
                      ],
                    ),
                  );
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: ApplicationItem(
                        appName:
                            state.appInfos[index].appName[0].toUpperCase() +
                                state.appInfos[index].appName.substring(1),
                        hours: formatDuration(state.appInfos[index].usage),
                      ),
                    ),
                    childCount: state.appInfos.length,
                  ),
                );
              }
              return const SliverToBoxAdapter();
            },
          ),
          SliverSizedBox(
            height: 30.h,
          ),
        ],
      ),
    );
  }

  String formatDuration(Duration duration) {
    String hoursPart = duration.inHours > 0 ? '${duration.inHours}h ' : '';
    String minutesPart =
        (duration.inMinutes % 60 > 0) ? '${duration.inMinutes % 60}m' : '';

    return '$hoursPart$minutesPart'.trim();
  }
}
