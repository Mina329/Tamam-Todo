import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/features/profile/domain/usecases/change_account_photo_use_case.dart';

part 'change_account_photo_state.dart';

class ChangeAccountPhotoCubit extends Cubit<ChangeAccountPhotoState> {
  ChangeAccountPhotoCubit(this.changeAccountPhotoUseCase)
      : super(ChangeAccountPhotoInitial());
  final ChangeAccountPhotoUseCase changeAccountPhotoUseCase;
  Future<void> changeAccountPhoto(File image) async {
    emit(ChangeAccountPhotoLoading());
    var res = await changeAccountPhotoUseCase.execute(image);
    res.fold(
      (failure) => emit(
        ChangeAccountPhotoFailure(
          errMessage: failure.message,
        ),
      ),
      (success) => emit(
        ChangeAccountPhotoSuccess(),
      ),
    );
  }
}
