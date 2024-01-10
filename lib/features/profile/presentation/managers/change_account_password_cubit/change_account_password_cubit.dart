import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/features/profile/domain/usecases/change_account_password_use_case.dart';

part 'change_account_password_state.dart';

class ChangeAccountPasswordCubit extends Cubit<ChangeAccountPasswordState> {
  ChangeAccountPasswordCubit(this.changeAccountPasswordUseCase)
      : super(ChangeAccountPasswordInitial());
  final ChangeAccountPasswordUseCase changeAccountPasswordUseCase;
  Future<void> changeAccountPassword(
      String oldPassword, String newPassword) async {
    emit(ChangeAccountPasswordLoading());
    var res =
        await changeAccountPasswordUseCase.execute((oldPassword, newPassword));
    res.fold(
      (failure) => emit(
        ChangeAccountPasswordFailure(
          errMessage: failure.message,
        ),
      ),
      (success) => emit(
        ChangeAccountPasswordSuccess(),
      ),
    );
  }
}
