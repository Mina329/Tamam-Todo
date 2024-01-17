part of 'delete_account_with_email_and_password_cubit.dart';

@immutable
sealed class DeleteAccountWithEmailAndPasswordState {}

final class DeleteAccountWithEmailAndPasswordInitial
    extends DeleteAccountWithEmailAndPasswordState {}

final class DeleteAccountWithEmailAndPasswordLoading
    extends DeleteAccountWithEmailAndPasswordState {}

final class DeleteAccountWithEmailAndPasswordFailure
    extends DeleteAccountWithEmailAndPasswordState {
  final String errMessage;

  DeleteAccountWithEmailAndPasswordFailure({required this.errMessage});
}

final class DeleteAccountWithEmailAndPasswordSuccess
    extends DeleteAccountWithEmailAndPasswordState {}
