part of 'register_user_with_email_and_password_cubit.dart';

@immutable
sealed class RegisterUserWithEmailAndPasswordState {}

final class RegisterUserWithEmailAndPasswordInitial
    extends RegisterUserWithEmailAndPasswordState {}

final class RegisterUserWithEmailAndPasswordSuccess
    extends RegisterUserWithEmailAndPasswordState {}

final class RegisterUserWithEmailAndPasswordLoading
    extends RegisterUserWithEmailAndPasswordState {}

final class RegisterUserWithEmailAndPasswordFailure
    extends RegisterUserWithEmailAndPasswordState {
  final String errMessage;

  RegisterUserWithEmailAndPasswordFailure({required this.errMessage});
}
