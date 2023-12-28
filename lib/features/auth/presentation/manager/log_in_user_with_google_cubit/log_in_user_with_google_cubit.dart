import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/features/auth/domain/usecases/log_in_user_with_google_use_case.dart';

part 'log_in_user_with_google_state.dart';

class LogInUserWithGoogleCubit extends Cubit<LogInUserWithGoogleState> {
  LogInUserWithGoogleCubit(this.logInUserWithGoogleUseCase)
      : super(LogInUserWithGoogleInitial());
  final LogInUserWithGoogleUseCase logInUserWithGoogleUseCase;

  Future<void> logInUserWithGoogle() async {
    emit(LogInUserWithGoogleLoading());

    var result = await logInUserWithGoogleUseCase.execute();

    result.fold(
      (failure) => emit(
        LogInUserWithGoogleFailure(errMessage: failure.message),
      ),
      (r) => emit(
        LogInUserWithGoogleSuccess(),
      ),
    );
  }
}
