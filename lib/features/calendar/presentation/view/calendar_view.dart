import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/calendar/presentation/manager/get_tasks_by_calendar_day_cubit/get_tasks_by_calendar_day_cubit.dart';
import 'package:todo/features/calendar/presentation/view/widgets/calendar_view_body.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetTasksByCalendarDayCubit>(context).getTaskByDay(
      day: DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, 0, 0, 0),
      isCompleted: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const CalendarViewBody();
  }
}
