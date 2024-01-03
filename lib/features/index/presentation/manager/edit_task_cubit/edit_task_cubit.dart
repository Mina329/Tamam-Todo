import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/features/home/domain/entities/task.dart';
import 'package:todo/features/index/domain/usecases/edit_task_use_case.dart';

part 'edit_task_state.dart';

class EditTaskCubit extends Cubit<EditTaskState> {
  EditTaskCubit(this.editTaskUseCase) : super(EditTaskInitial());
  final EditTaskUseCase editTaskUseCase;

  Future<void> editTask(TaskEntity oldTask, TaskEntity newTask) async {
    emit(EditTaskLoading());
    var result = await editTaskUseCase.execute((oldTask, newTask));
    result.fold(
      (failure) => emit(
        EditTaskFailure(
          errMessage: failure.message,
        ),
      ),
      (r) => emit(
        EditTaskSuccess(),
      ),
    );
  }
}
