import 'package:todo/features/home/domain/entities/category.dart';
import 'package:todo/features/home/domain/entities/task.dart';

abstract class HomeLocalDataSource {
  List<CategoryEntity> getAllCategories();
  Future<void> createTask(TaskEntity task);
  Future<void> createCategory(CategoryEntity categoryData);
  Future<void> deleteCategory(String categoryId);
}
