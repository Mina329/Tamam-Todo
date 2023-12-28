part of 'log_in_user_with_email_and_password_cubit.dart';

@immutable
sealed class LogInUserWithEmailAndPasswordState {}

final class LogInUserWithEmailAndPasswordInitial
    extends LogInUserWithEmailAndPasswordState {}

final class LogInUserWithEmailAndPasswordLoading
    extends LogInUserWithEmailAndPasswordState {}

final class LogInUserWithEmailAndPasswordSuccess
    extends LogInUserWithEmailAndPasswordState {
  final UserCredential user;

  LogInUserWithEmailAndPasswordSuccess({required this.user});
}

final class LogInUserWithEmailAndPasswordFailure
    extends LogInUserWithEmailAndPasswordState {
  final String errMessage;

  LogInUserWithEmailAndPasswordFailure({required this.errMessage});
}
