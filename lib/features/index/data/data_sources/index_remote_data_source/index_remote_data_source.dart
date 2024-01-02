import 'package:todo/features/home/domain/entities/task.dart';

abstract class IndexRemoteDataSource {
  Future<List<TaskEntity>> getTasksByDay(DateTime day);
}
