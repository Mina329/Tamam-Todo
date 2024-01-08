part of 'get_focused_time_cubit.dart';

@immutable
sealed class GetFocusedTimeState {}

final class GetFocusedTimeInitial extends GetFocusedTimeState {}

final class GetFocusedTimeLoading extends GetFocusedTimeState {}

final class GetFocusedTimeSuccess extends GetFocusedTimeState {
  final int seconds;

  GetFocusedTimeSuccess({required this.seconds});
}

final class GetFocusedTimeFailure extends GetFocusedTimeState {
  final String errMessage;

  GetFocusedTimeFailure({required this.errMessage});
}
