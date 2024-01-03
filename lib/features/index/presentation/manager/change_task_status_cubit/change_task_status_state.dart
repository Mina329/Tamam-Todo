part of 'change_task_status_cubit.dart';

@immutable
sealed class ChangeTaskStatusState {}

final class ChangeTaskStatusInitial extends ChangeTaskStatusState {}

final class ChangeTaskStatusLoading extends ChangeTaskStatusState {}

final class ChangeTaskStatusSuccess extends ChangeTaskStatusState {}

final class ChangeTaskStatusFailure extends ChangeTaskStatusState {
  final String errMessage;

  ChangeTaskStatusFailure({required this.errMessage});
}
