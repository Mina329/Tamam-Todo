import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/features/profile/domain/usecases/change_account_name_use_case.dart';

part 'change_account_name_state.dart';

class ChangeAccountNameCubit extends Cubit<ChangeAccountNameState> {
  ChangeAccountNameCubit(this.changeAccountNameUseCase)
      : super(ChangeAccountNameInitial());
  final ChangeAccountNameUseCase changeAccountNameUseCase;
  Future<void> changeAccountName(String name) async {
    emit(ChangeAccountNameLoading());
    var res = await changeAccountNameUseCase.execute(name);
    res.fold(
      (failure) => emit(
        ChangeAccountNameFailure(
          errMessage: failure.message,
        ),
      ),
      (success) => emit(
        ChangeAccountNameSuccess(),
      ),
    );
  }
}
