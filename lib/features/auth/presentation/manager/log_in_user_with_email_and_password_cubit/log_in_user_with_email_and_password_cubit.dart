import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/features/auth/domain/entities/user.dart';
import 'package:todo/features/auth/domain/usecases/log_in_user_with_email_and_password_use_case.dart';

part 'log_in_user_with_email_and_password_state.dart';

class LogInUserWithEmailAndPasswordCubit
    extends Cubit<LogInUserWithEmailAndPasswordState> {
  LogInUserWithEmailAndPasswordCubit(this.logInUserWithEmailAndPasswordUseCase)
      : super(LogInUserWithEmailAndPasswordInitial());
  final LogInUserWithEmailAndPasswordUseCase
      logInUserWithEmailAndPasswordUseCase;
  Future<void> logInUserWithEmailAndPassword(UserData user) async {
    emit(LogInUserWithEmailAndPasswordLoading());

    var result = await logInUserWithEmailAndPasswordUseCase.execute(
      user,
    );

    result.fold(
      (failure) => emit(
        LogInUserWithEmailAndPasswordFailure(errMessage: failure.message),
      ),
      (r) => emit(
        LogInUserWithEmailAndPasswordSuccess(),
      ),
    );
  }
}
