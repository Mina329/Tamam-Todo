import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/features/profile/domain/usecases/delete_account_use_case.dart';

part 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit(this.deleteAccountUseCase) : super(DeleteAccountInitial());
  final DeleteAccountUseCase deleteAccountUseCase;
  Future<void> deleteAccount(String? password) async {
    emit(DeleteAccountLoading());
    var res = await deleteAccountUseCase.execute(password);
    res.fold(
      (failure) => emit(
        DeleteAccountFailure(
          errMessage: failure.message,
        ),
      ),
      (success) => emit(
        DeleteAccountSuccess(),
      ),
    );
  }
}
