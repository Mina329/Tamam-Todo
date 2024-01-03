import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/features/index/domain/usecases/delete_task_use_case.dart';

part 'delete_task_state.dart';

class DeleteTaskCubit extends Cubit<DeleteTaskState> {
  DeleteTaskCubit(this.deleteTaskUseCase) : super(DeleteTaskInitial());
  final DeleteTaskUseCase deleteTaskUseCase;

  Future<void> deleteTask(String taskId) async {
    emit(DeleteTaskLoading());
    var result = await deleteTaskUseCase.execute(taskId);
    result.fold(
      (failure) => emit(
        DeleteTaskFailure(
          errMessage: failure.message,
        ),
      ),
      (r) => emit(
        DeleteTaskSuccess(),
      ),
    );
  }
}
