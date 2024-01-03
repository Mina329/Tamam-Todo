import 'package:todo/features/home/domain/entities/task.dart';

abstract class IndexLocalDataSource {
  Future<void> changeTaskStatus(String status,String taskId);
  List<TaskEntity> getTasksByDay(DateTime day);
}
