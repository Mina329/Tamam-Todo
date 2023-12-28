import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/features/auth/domain/usecases/verify_email_use_case.dart';

part 'verify_email_state.dart';

class VerifyEmailCubit extends Cubit<VerifyEmailState> {
  VerifyEmailCubit(this.verifyEmailUseCase) : super(VerifyEmailInitial());
  final VerifyEmailUseCase verifyEmailUseCase;
  Future<void> verifyEmail() async {
    emit(VerifyEmailLoading());

    var result = await verifyEmailUseCase.execute();

    result.fold(
      (failure) => emit(
        VerifyEmailFailure(errMessage: failure.message),
      ),
      (r) => emit(
        VerifyEmailSuccess(),
      ),
    );
  }
}
