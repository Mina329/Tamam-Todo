part of 'change_tasks_to_uncompleted_cubit.dart';

@immutable
sealed class ChangeTasksToUncompletedState {}

final class ChangeTasksToUncompletedInitial
    extends ChangeTasksToUncompletedState {}

final class ChangeTasksToUncompletedSuccess
    extends ChangeTasksToUncompletedState {}

final class ChangeTasksToUncompletedFailure
    extends ChangeTasksToUncompletedState {
  final String errMessage;

  ChangeTasksToUncompletedFailure({required this.errMessage});
}
