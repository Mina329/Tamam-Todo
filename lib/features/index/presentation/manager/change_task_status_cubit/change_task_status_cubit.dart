import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/features/index/domain/usecases/change_task_status_use_case.dart';

part 'change_task_status_state.dart';

class ChangeTaskStatusCubit extends Cubit<ChangeTaskStatusState> {
  ChangeTaskStatusCubit(this.changeTaskStatusUseCase)
      : super(ChangeTaskStatusInitial());
  final ChangeTaskStatusUseCase changeTaskStatusUseCase;

  Future<void> changeTaskStatus(String status, String taskId) async {
    emit(ChangeTaskStatusLoading());
    var result = await changeTaskStatusUseCase.execute((status, taskId));
    result.fold(
      (failure) => emit(
        ChangeTaskStatusFailure(
          errMessage: failure.message,
        ),
      ),
      (r) => emit(
        ChangeTaskStatusSuccess(),
      ),
    );
  }
}
