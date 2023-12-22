import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/features/focus/presentation/view/widgets/bar_graph_widget.dart';

class OverviewSection extends StatelessWidget {
  const OverviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringsManager.overview,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(
          height: 35.h,
        ),
        BarGraphWidget(
          weekdays: const ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'],
          seconds: const [5400, 12600, 21660, 31080, 8400, 10800, 2280],
          today: DateFormat('EEEE')
              .format(DateTime.now())
              .substring(0, 3)
              .toUpperCase(),
        ),
      ],
    );
  }
}
