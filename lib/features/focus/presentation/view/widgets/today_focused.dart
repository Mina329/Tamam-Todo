import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/features/focus/presentation/managers/get_focused_time_cubit/get_focused_time_cubit.dart';

class TodayFocused extends StatelessWidget {
  const TodayFocused({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocConsumer<GetFocusedTimeCubit, GetFocusedTimeState>(
          listener: (context, state) {
            if (state is GetFocusedTimeFailure) {
              Fluttertoast.showToast(msg: state.errMessage);
            }
          },
          builder: (context, state) {
            if (state is GetFocusedTimeLoading) {
              return const SizedBox();
            } else if (state is GetFocusedTimeFailure) {
              return const SizedBox();
            } else if (state is GetFocusedTimeSuccess) {
              return Text(
                '${StringsManager.youHaveFocused.tr()}${buildTimeText(state.seconds)} ${StringsManager.today.tr()}',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              );
            }
            return const SizedBox();
          },
        ),
        SizedBox(
          height: 25.h,
        ),
      ],
    );
  }

  String buildTimeText(int seconds) {
    final int hours = seconds ~/ 3600;
    final int minutes = (seconds % 3600) ~/ 60;

    String result = '';

    if (hours > 0) {
      result += '${hours}h ';
    }

    if (minutes > 0) {
      result += '${minutes}m';
    }

    if (result.isEmpty) {
      result = '0m';
    }

    return result;
  }
}
