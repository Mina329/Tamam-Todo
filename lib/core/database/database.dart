import 'package:hive/hive.dart';
import 'package:todo/features/home/domain/entities/category.dart';
import 'package:todo/features/home/domain/entities/task.dart';

const kTasksBox = 'tasks_box';
const kCategoriesBox = 'categories_box';

Future<void> setupDataBase() async {
  Hive.registerAdapter(CategoryDataAdapter());
  Hive.registerAdapter(TaskEntityAdapter());
  await Hive.openBox<TaskEntity>(kTasksBox);
  await Hive.openBox<CategoryData>(kCategoriesBox);
}
