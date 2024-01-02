part of 'get_tasks_by_day_cubit.dart';

@immutable
sealed class GetTasksByDayState {}

final class GetTasksByDayInitial extends GetTasksByDayState {}

final class GetTasksByDayLoading extends GetTasksByDayState {}

final class GetTasksByDayFailure extends GetTasksByDayState {
  final String errMessage;

  GetTasksByDayFailure({required this.errMessage});
}

final class GetTasksByDaySuccess extends GetTasksByDayState {
  final List<TaskEntity> uncompleted;
  final List<TaskEntity> completed;

  GetTasksByDaySuccess({required this.uncompleted, required this.completed});
}
