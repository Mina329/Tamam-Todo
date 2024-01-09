import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/utils/service_locator.dart';
import 'package:todo/features/focus/domain/usecases/add_time_for_today_use_case.dart';
import 'package:todo/features/focus/domain/usecases/get_apps_usage_list_use_case.dart';
import 'package:todo/features/focus/domain/usecases/get_focused_time_use_case.dart';
import 'package:todo/features/focus/presentation/managers/add_focused_time_cubit/add_focused_time_cubit.dart';
import 'package:todo/features/focus/presentation/managers/get_apps_usage_list_cubit/get_apps_usage_list_cubit.dart';
import 'package:todo/features/focus/presentation/managers/get_focused_time_cubit/get_focused_time_cubit.dart';
import 'package:todo/features/focus/presentation/view/widgets/focus_view_body.dart';

class FocusView extends StatelessWidget {
  const FocusView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetFocusedTimeCubit(
            getIt.get<GetFocusedTimeUseCase>(),
          )..getFocusedTime(),
        ),
        BlocProvider(
          create: (context) => AddFocusedTimeCubit(
            getIt.get<AddTimeForTodayUseCase>(),
          ),
        ),
        BlocProvider(
          create: (context) => GetAppsUsageListCubit(
            getIt.get<GetAppsUsageListUseCase>(),
          )..getAppsUsageList(),
        )
      ],
      child: const FocusViewBody(),
    );
  }
}
