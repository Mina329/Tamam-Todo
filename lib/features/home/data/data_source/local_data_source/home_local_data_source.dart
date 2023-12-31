import 'package:todo/features/home/domain/entities/category.dart';
import 'package:todo/features/home/domain/entities/task.dart';

abstract class HomeLocalDataSource {
  List<CategoryData> getAllCategories();
  Future<void> createTask(TaskEntity task);
  Future<void> createCategory(CategoryData categoryData);
}
