import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/features/home/domain/entities/task.dart';
import 'package:todo/features/index/domain/usecases/get_task_by_day_use_case.dart';

part 'get_tasks_by_calendar_day_state.dart';

class GetTasksByCalendarDayCubit extends Cubit<GetTasksByCalendarDayState> {
  GetTasksByCalendarDayCubit(this.getTaskByDayUseCase)
      : super(GetTasksByCalendarDayInitial());
  final GetTaskByDayUseCase getTaskByDayUseCase;
  DateTime? storedDay;
  bool storedIsCompleted = false;
  Future<void> getTaskByDay({DateTime? day, required bool? isCompleted}) async {
    emit(GetTasksByCalendarDayLoading());
    if (day != null) {
      storedDay = day;
    }
    if (isCompleted != null) {
      storedIsCompleted = isCompleted;
    }
    var result = await getTaskByDayUseCase.execute(
      day ?? storedDay ?? DateTime.now(),
    );
    result.fold(
      (failure) {
        return emit(
          GetTasksByCalendarDayFailure(errMessage: failure.message),
        );
      },
      (tasks) async {
        (List<TaskEntity>, List<TaskEntity>) tasksSplitted = splitTasks(tasks);
        await Future.delayed(const Duration(milliseconds: 200));
        return emit(
          GetTasksByCalendarDaySuccess(
              tasks: storedIsCompleted ? tasksSplitted.$2 : tasksSplitted.$1),
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
