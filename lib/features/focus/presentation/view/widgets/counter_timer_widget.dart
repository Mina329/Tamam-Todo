import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dnd/flutter_dnd.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo/core/utils/color_manager.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/features/focus/presentation/managers/add_focused_time_cubit/add_focused_time_cubit.dart';
import 'package:todo/features/focus/presentation/managers/get_focused_time_cubit/get_focused_time_cubit.dart';

class CounterTimerWidget extends StatefulWidget {
  const CounterTimerWidget({Key? key}) : super(key: key);

  @override
  CounterTimerWidgetState createState() => CounterTimerWidgetState();
}

class CounterTimerWidgetState extends State<CounterTimerWidget> {
  static int timerSeconds = 0;
  static int timerMinutes = 0;
  static int timerHours = 0;
  static bool isTimerRunning = false;
  static late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (isTimerRunning) {
          setState(() {
            timerSeconds++;
            if (timerSeconds == 60) {
              timerSeconds = 0;
              timerMinutes++;
              if (timerMinutes == 60) {
                timerMinutes = 0;
                timerHours++;
              }
            }
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: Text(
                  '${_twoDigits(timerHours)}:${_twoDigits(timerMinutes)}:${_twoDigits(timerSeconds)}',
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
              ),
              CircleAvatar(
                radius: MediaQuery.of(context).size.width / 2 - 80.w,
                backgroundColor: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 10.w,
                      color: ColorManager.primaryColor,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
            child: Text(
              StringsManager.notificationSuppress.tr(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          BlocListener<AddFocusedTimeCubit, AddFocusedTimeState>(
            listener: (context, state) {
              if (state is AddFocusedTimeFailure) {
                Fluttertoast.showToast(msg: state.errMessage);
              } else if (state is AddFocusedTimeSuccess) {
                BlocProvider.of<GetFocusedTimeCubit>(context).getFocusedTime();
              }
            },
            child: ElevatedButton(
              onPressed: _toggleTimer,
              child: Text(
                isTimerRunning
                    ? StringsManager.stopFocusing.tr()
                    : StringsManager.startFocusing.tr(),
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  void _toggleTimer() async {
    bool hasPermission = await _checkAndRequestPermission();
    if (hasPermission && context.mounted) {
      setState(() {
        isTimerRunning = !isTimerRunning;
      });

      if (!isTimerRunning) {
        BlocProvider.of<AddFocusedTimeCubit>(context)
            .addFocusedTime(_saveTotalTime());

        await FlutterDnd.setInterruptionFilter(
          FlutterDnd.INTERRUPTION_FILTER_ALL,
        );
      } else {
        await FlutterDnd.setInterruptionFilter(
          FlutterDnd.INTERRUPTION_FILTER_NONE,
        );
      }
    }
  }

  Future<bool> _checkAndRequestPermission() async {
    bool isPermissionGranted =
        await FlutterDnd.isNotificationPolicyAccessGranted ?? false;

    if (!isPermissionGranted) {
      FlutterDnd.gotoPolicySettings();
    }

    return isPermissionGranted;
  }

  int _saveTotalTime() {
    int totalSeconds = timerHours * 3600 + timerMinutes * 60 + timerSeconds;
    timerHours = 0;
    timerMinutes = 0;
    timerSeconds = 0;
    return totalSeconds;
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
