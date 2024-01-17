import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tamam_account_delete/domain/usecases/delete_account_with_google_use_case.dart';

part 'delete_account_with_google_state.dart';

class DeleteAccountWithGoogleCubit extends Cubit<DeleteAccountWithGoogleState> {
  DeleteAccountWithGoogleCubit(this.deleteAccountWithGoogleUseCase)
      : super(DeleteAccountWithGoogleInitial());
  final DeleteAccountWithGoogleUseCase deleteAccountWithGoogleUseCase;
  Future<void> deleteAccountWithGoogle() async {
    emit(DeleteAccountWithGoogleLoading());
    var res = await deleteAccountWithGoogleUseCase.execute();
    res.fold(
      (failure) => emit(
        DeleteAccountWithGoogleFailure(
          errMessage: failure.message,
        ),
      ),
      (success) => emit(
        DeleteAccountWithGoogleSuccess(),
      ),
    );
  }
}
