import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/features/home/domain/entities/task.dart';
import 'package:todo/features/index/domain/usecases/get_task_by_day_use_case.dart';

part 'get_tasks_by_day_state.dart';

class GetTasksByDayCubit extends Cubit<GetTasksByDayState> {
  GetTasksByDayCubit(this.getTaskByDayUseCase) : super(GetTasksByDayInitial());
  final GetTaskByDayUseCase getTaskByDayUseCase;
  DateTime? storedDate;
  Future<void> getTaskByDay(DateTime? day) async {
    emit(GetTasksByDayLoading());
    if (day != null) {
      storedDate = day;
    }
    var result = await getTaskByDayUseCase.execute(day ?? storedDate);
    result.fold(
      (failure) {
        return emit(
          GetTasksByDayFailure(errMessage: failure.message),
        );
      },
      (tasks) {
        (List<TaskEntity>, List<TaskEntity>) tasksSplitted = splitTasks(tasks);
        return emit(
          GetTasksByDaySuccess(
            uncompleted: tasksSplitted.$1,
            completed: tasksSplitted.$2,
          ),
        );
      },
    );
  }

  (List<TaskEntity> uncompleted, List<TaskEntity> completed) splitTasks(
      List<TaskEntity> tasks) {
    List<TaskEntity> completed = [];
    List<TaskEntity> uncompleted = [];
    for (TaskEntity task in tasks) {
      if (task.status == 'completed') {
        completed.add(task);
      } else {
        uncompleted.add(task);
      }
    }
    return (uncompleted, completed);
  }
}
