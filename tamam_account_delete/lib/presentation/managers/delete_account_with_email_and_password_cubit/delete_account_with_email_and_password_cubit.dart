import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tamam_account_delete/domain/usecases/delete_account_with_email_and_password_use_case.dart';

part 'delete_account_with_email_and_password_state.dart';

class DeleteAccountWithEmailAndPasswordCubit
    extends Cubit<DeleteAccountWithEmailAndPasswordState> {
  DeleteAccountWithEmailAndPasswordCubit(
      this.deleteAccountWithEmailAndPasswordUseCase)
      : super(DeleteAccountWithEmailAndPasswordInitial());
  final DeleteAccountWithEmailAndPasswordUseCase
      deleteAccountWithEmailAndPasswordUseCase;

  Future<void> deleteAccountWithEmailAndPassword(
      String email, String password) async {
    emit(DeleteAccountWithEmailAndPasswordLoading());
    var res = await deleteAccountWithEmailAndPasswordUseCase
        .execute((email, password));
    res.fold(
      (failure) => emit(
        DeleteAccountWithEmailAndPasswordFailure(
          errMessage: failure.message,
        ),
      ),
      (success) => emit(
        DeleteAccountWithEmailAndPasswordSuccess(),
      ),
    );
  }
}
