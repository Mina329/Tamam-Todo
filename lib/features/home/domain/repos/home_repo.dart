import 'package:dartz/dartz.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/features/home/domain/entities/category.dart';
import 'package:todo/features/home/domain/entities/task.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<CategoryEntity>>> getAllCategories();
  Future<Either<Failure, void>> createTask(TaskEntity task);
  Future<Either<Failure, void>> createCategory(CategoryEntity categoryData);
  Future<Either<Failure, void>> deleteCategory(String categoryId);
}
