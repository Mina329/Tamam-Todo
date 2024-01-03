part of 'edit_task_cubit.dart';

@immutable
sealed class EditTaskState {}

final class EditTaskInitial extends EditTaskState {}

final class EditTaskLoading extends EditTaskState {}

final class EditTaskSuccess extends EditTaskState {}

final class EditTaskFailure extends EditTaskState {
  final String errMessage;

  EditTaskFailure({required this.errMessage});
}
