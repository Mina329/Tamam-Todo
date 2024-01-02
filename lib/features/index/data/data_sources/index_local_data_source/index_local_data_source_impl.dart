import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/core/database/database.dart';
import 'package:todo/features/home/domain/entities/task.dart';
import 'package:todo/features/index/data/data_sources/index_local_data_source/index_local_data_source.dart';

class IndexLocalDataSourceImpl extends IndexLocalDataSource {
  @override
  List<TaskEntity> getTasksByDay(DateTime day) {
    var box = Hive.box<TaskEntity>(kTasksBox);
    List<TaskEntity> tasks = [];
    DateTime endDate = day.add(const Duration(days: 1));

    for (var taskEntity in box.values.toList()) {
      if (taskEntity.utcTime.isAfter(day) &&
          taskEntity.utcTime.isBefore(endDate)) {
        tasks.add(taskEntity);
      }
    }
    return tasks;
  }
}
