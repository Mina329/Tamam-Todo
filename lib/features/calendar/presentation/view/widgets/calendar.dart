import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo/core/utils/color_manager.dart';
import 'package:todo/features/calendar/presentation/view/widgets/custom_day_widget.dart';

class Calendar extends StatefulWidget {
  const Calendar({
    super.key,
    required this.onDaySelected,
  });
  final Function(DateTime) onDaySelected;
  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _focusedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).brightness == Brightness.dark
          ? ColorManager.greyColor
          : Colors.grey[200],
      padding: EdgeInsets.only(
        bottom: 10.h,
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2000, 1, 1),
        lastDay: DateTime.utc(2124, 1, 1),
        focusedDay: _focusedDay,
        currentDay: _focusedDay,
        selectedDayPredicate: (DateTime date) {
          return isSameDay(_focusedDay, date);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _focusedDay = selectedDay;
          });
          widget.onDaySelected(_focusedDay);
        },
        calendarFormat: CalendarFormat.week,
        daysOfWeekVisible: false,
        calendarBuilders: CalendarBuilders(
          defaultBuilder: _buildDayWidget,
          disabledBuilder: _buildDayWidget,
          selectedBuilder: _buildSelectedDayWidget,
          outsideBuilder: _buildDayWidget,
        ),
        headerStyle: HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
          titleTextStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
          leftChevronMargin: EdgeInsets.symmetric(horizontal: 30.w),
          rightChevronMargin: EdgeInsets.symmetric(horizontal: 30.w),
        ),
        onHeaderTapped: _onHeaderTapped,
      ),
    );
  }

  Future<Function(DateTime p1)?> _onHeaderTapped(selectedDate) async {
    await showMonthPicker(
      context: context,
      initialDate: DateTime.now(),
      dismissible: true,
      firstDate: DateTime.utc(2000, 1, 1),
      lastDate: DateTime.utc(2124, 1, 1),
      roundedCornersRadius: 20,
    ).then(
      (date) {
        if (date != null) {
          setState(() {
            _focusedDay = date;
          });
          widget.onDaySelected(_focusedDay);
        }
      },
    );
    return null;
  }

  Widget? _buildDayWidget(context, date, events) {
    String weekDay =
        DateFormat('EEEE').format(date).substring(0, 3).toUpperCase();
    String day = DateFormat('d').format(date);
    return CustomDayWidget(
      weekDay: weekDay,
      day: day,
      selected: false,
    );
  }

  Widget? _buildSelectedDayWidget(context, date, events) {
    String weekDay =
        DateFormat('EEEE').format(date).substring(0, 3).toUpperCase();
    String day = DateFormat('d').format(date);
    return CustomDayWidget(
      weekDay: weekDay,
      day: day,
      selected: true,
    );
  }
}
