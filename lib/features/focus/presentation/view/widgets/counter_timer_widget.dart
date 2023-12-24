import 'dart:async';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/utils/color_manager.dart';
import 'package:todo/core/utils/strings_manager.dart';

class CounterTimerWidget extends StatefulWidget {
  const CounterTimerWidget({Key? key}) : super(key: key);

  @override
  CounterTimerWidgetState createState() => CounterTimerWidgetState();
}

class CounterTimerWidgetState extends State<CounterTimerWidget> {
  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  bool isTimerRunning = false;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (isTimerRunning) {
          setState(() {
            seconds++;
            if (seconds == 60) {
              seconds = 0;
              minutes++;
              if (minutes == 60) {
                minutes = 0;
                hours++;
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
                  '${_twoDigits(hours)}:${_twoDigits(minutes)}:${_twoDigits(seconds)}',
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
          ElevatedButton(
            onPressed: () {
              setState(() {
                isTimerRunning = !isTimerRunning;
                if (!isTimerRunning) {
                  log(
                    _saveTotalTime().toString(),
                  );
                }
              });
            },
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
        ],
      ),
    );
  }

  String _twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  int _saveTotalTime() {
    int totalSeconds = hours * 3600 + minutes * 60 + seconds;
    hours = 0;
    minutes = 0;
    seconds = 0;
    return totalSeconds;
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
