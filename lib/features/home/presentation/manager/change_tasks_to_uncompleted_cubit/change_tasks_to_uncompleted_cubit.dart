import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/features/home/domain/usecases/change_tasks_to_uncompleted.dart';
import 'package:todo/features/home/domain/usecases/delete_old_tasks_use_case.dart';

part 'change_tasks_to_uncompleted_state.dart';

class ChangeTasksToUncompletedCubit
    extends Cubit<ChangeTasksToUncompletedState> {
  ChangeTasksToUncompletedCubit(
      this.changeTasksToUncompletedUseCase, this.deleteOldTasksUseCase)
      : super(ChangeTasksToUncompletedInitial());
  final ChangeTasksToUncompletedUseCase changeTasksToUncompletedUseCase;
  final DeleteOldTasksUseCase deleteOldTasksUseCase;
  Future<void> changeTasksToUncompleted() async {
    emit(ChangeTasksToUncompletedInitial());
    await deleteOldTasksUseCase.execute();
    var res = await changeTasksToUncompletedUseCase.execute();
    res.fold(
      (failure) => emit(
        ChangeTasksToUncompletedFailure(
          errMessage: failure.message,
        ),
      ),
      (success) => emit(
        ChangeTasksToUncompletedSuccess(),
      ),
    );
  }
}
