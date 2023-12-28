import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/auth/domain/entities/user.dart';
import 'package:todo/features/auth/domain/usecases/register_user_with_email_and_password_use_case.dart';

part 'register_user_with_email_and_password_state.dart';

class RegisterUserWithEmailAndPasswordCubit
    extends Cubit<RegisterUserWithEmailAndPasswordState> {
  RegisterUserWithEmailAndPasswordCubit(
      this.registerUserWithEmailAndPasswordUseCase)
      : super(RegisterUserWithEmailAndPasswordInitial());
  final RegisterUserWithEmailAndPasswordUseCase
      registerUserWithEmailAndPasswordUseCase;
  Future<void> registerUserWithEmailAndPassword(UserData user) async {
    emit(RegisterUserWithEmailAndPasswordLoading());

    var result = await registerUserWithEmailAndPasswordUseCase.execute(
      user,
    );

    result.fold(
      (failure) => emit(
        RegisterUserWithEmailAndPasswordFailure(errMessage: failure.message),
      ),
      (r) => emit(
        RegisterUserWithEmailAndPasswordSuccess(),
      ),
    );
  }
}
