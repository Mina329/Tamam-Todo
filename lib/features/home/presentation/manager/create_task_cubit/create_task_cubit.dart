import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/features/home/domain/entities/task.dart';
import 'package:todo/features/home/domain/usecases/create_task_use_case.dart';

part 'create_task_state.dart';

class CreateTaskCubit extends Cubit<CreateTaskState> {
  CreateTaskCubit(this.createTaskUseCase) : super(CreateTaskInitial());
  final CreateTaskUseCase createTaskUseCase;
  Future<void> createTask(TaskEntity task) async {
    emit(CreateTaskLoading());
    var result = await createTaskUseCase.execute(task);
    result.fold(
      (failure) => emit(
        CreateTaskFailure(errMessage: failure.message),
      ),
      (success) => emit(
        CreateTaskSuccess(),
      ),
    );
  }
}
