import 'package:dartz/dartz.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/features/home/domain/entities/category.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<CategoryData>>> getAllCategories();
  Future<Either<Failure, void>> createTask(Task task);
  Future<Either<Failure, void>> createCategory(CategoryData categoryData);
}
