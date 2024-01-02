import 'package:todo/features/home/domain/entities/task.dart';

abstract class IndexLocalDataSource {
  List<TaskEntity> getTasksByDay(DateTime day);
}
