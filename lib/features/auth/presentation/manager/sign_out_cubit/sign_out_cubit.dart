import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/features/auth/domain/usecases/sign_out_use_case.dart';

part 'sign_out_state.dart';

class SignOutCubit extends Cubit<SignOutState> {
  SignOutCubit(this.signOutUseCase) : super(SignOutInitial());
  final SignOutUseCase signOutUseCase;
  Future<void> signOut() async {
    emit(SignOutLoading());
    var result = await signOutUseCase.execute();
    result.fold(
      (failure) => emit(
        SignOutFailure(errMessage: failure.message),
      ),
      (r) => emit(
        SignOutSuccess(),
      ),
    );
  }
}
