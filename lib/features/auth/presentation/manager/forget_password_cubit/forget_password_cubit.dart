import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/features/auth/domain/usecases/forget_password_use_case.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit(this.forgetPasswordUseCase)
      : super(ForgetPasswordInitial());
  final ForgetPasswordUseCase forgetPasswordUseCase;
  Future<void> forgetPassword(String email) async {
    emit(ForgetPasswordLoading());

    var result = await forgetPasswordUseCase.execute(email);

    result.fold(
      (failure) => emit(
        ForgetPasswordFailure(errMessage: failure.message),
      ),
      (r) => emit(
        ForgetPasswordSuccess(),
      ),
    );
  }
}
