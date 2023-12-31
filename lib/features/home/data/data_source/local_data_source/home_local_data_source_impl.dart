import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/core/database/database.dart';
import 'package:todo/features/home/data/data_source/local_data_source/home_local_data_source.dart';
import 'package:todo/features/home/domain/entities/category.dart';
import 'package:todo/features/home/domain/entities/task.dart';

class HomeLocalDataSourceImpl extends HomeLocalDataSource {
  @override
  Future<void> createCategory(CategoryEntity categoryData) async {
    var box = Hive.box<CategoryEntity>(kCategoriesBox);
    await box.add(categoryData);
  }

  @override
  Future<void> createTask(TaskEntity task) async {
    var box = Hive.box<TaskEntity>(kTasksBox);
    await box.add(task);
  }

  @override
  List<CategoryEntity> getAllCategories() {
    var box = Hive.box<CategoryEntity>(kCategoriesBox);
    return box.values.toList();
  }
}
