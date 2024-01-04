part of 'get_tasks_by_calendar_day_cubit.dart';

@immutable
sealed class GetTasksByCalendarDayState {}

final class GetTasksByCalendarDayInitial extends GetTasksByCalendarDayState {}

final class GetTasksByCalendarDayLoading extends GetTasksByCalendarDayState {}

final class GetTasksByCalendarDayFailure extends GetTasksByCalendarDayState {
  final String errMessage;

  GetTasksByCalendarDayFailure({required this.errMessage});
}

final class GetTasksByCalendarDaySuccess extends GetTasksByCalendarDayState {
  final List<TaskEntity> tasks;

  GetTasksByCalendarDaySuccess({required this.tasks});
}
