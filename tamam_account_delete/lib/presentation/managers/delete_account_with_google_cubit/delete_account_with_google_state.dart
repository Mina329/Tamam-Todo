part of 'delete_account_with_google_cubit.dart';

@immutable
sealed class DeleteAccountWithGoogleState {}

final class DeleteAccountWithGoogleInitial
    extends DeleteAccountWithGoogleState {}

final class DeleteAccountWithGoogleLoading
    extends DeleteAccountWithGoogleState {}

final class DeleteAccountWithGoogleSuccess
    extends DeleteAccountWithGoogleState {}

final class DeleteAccountWithGoogleFailure
    extends DeleteAccountWithGoogleState {
  final String errMessage;

  DeleteAccountWithGoogleFailure({required this.errMessage});
}
