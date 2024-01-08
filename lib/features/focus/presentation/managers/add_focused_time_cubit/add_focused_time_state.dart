part of 'add_focused_time_cubit.dart';

@immutable
sealed class AddFocusedTimeState {}

final class AddFocusedTimeInitial extends AddFocusedTimeState {}

final class AddFocusedTimeLoading extends AddFocusedTimeState {}

final class AddFocusedTimeSuccess extends AddFocusedTimeState {}

final class AddFocusedTimeFailure extends AddFocusedTimeState {
  final String errMessage;

  AddFocusedTimeFailure({required this.errMessage});
}
