import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/features/home/domain/entities/category.dart';
import 'package:todo/features/home/domain/entities/task.dart';

Future<void> saveCategories(List<CategoryEntity> items, String boxName) async {
  var box = Hive.box<CategoryEntity>(boxName);
  await box.addAll(items);
}
Future<void> saveTasks(List<TaskEntity> items, String boxName) async {
  var box = Hive.box<TaskEntity>(boxName);
  await box.addAll(items);
}