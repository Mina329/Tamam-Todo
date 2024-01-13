import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/features/home/data/data_source/local_data_source/home_local_data_source.dart';
import 'package:todo/features/home/data/data_source/remote_data_source/home_remote_data_source.dart';
import 'package:todo/features/home/domain/entities/category.dart';
import 'package:todo/features/home/domain/entities/task.dart';
import 'package:todo/features/home/domain/repos/home_repo.dart';

class HomeRepoImpl extends HomeRepo {
  final HomeLocalDataSource homeLocalDataSource;
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepoImpl(
      {required this.homeLocalDataSource, required this.homeRemoteDataSource});
  @override
  Future<Either<Failure, void>> createCategory(
      CategoryEntity categoryData) async {
    try {
      await homeRemoteDataSource.createCategory(categoryData);
      await homeLocalDataSource.createCategory(categoryData);
      return right(null);
    } catch (e) {
      return left(
        Failure(
          message: StringsManager.operationNotAllowed.tr(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> createTask(TaskEntity task) async {
    try {
      await homeRemoteDataSource.createTask(task);
      await homeLocalDataSource.createTask(task);
      return right(null);
    } catch (e) {
      return left(
        Failure(
          message: StringsManager.operationNotAllowed.tr(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getAllCategories() async {
    try {
      var categories = homeLocalDataSource.getAllCategories();
      if (categories.isNotEmpty) {
        return right(categories);
      }
      var categoriesList = await homeRemoteDataSource.getAllCategories();
      return right(categoriesList);
    } catch (e) {
      return left(
        Failure(
          message: StringsManager.operationNotAllowed.tr(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteCategory(String categoryId) async {
    try {
      await homeRemoteDataSource.deleteCategory(categoryId);
      await homeLocalDataSource.deleteCategory(categoryId);
      return right(null);
    } catch (e) {
      return left(
        Failure(
          message: StringsManager.operationNotAllowed.tr(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> changeTasksToUncompleted() async {
    try {
      await homeRemoteDataSource.changeTasksToUncompleted();
      return right(null);
    } catch (e) {
      return left(
        Failure(
          message: StringsManager.operationNotAllowed.tr(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteOldTasks() async {
    try {
      await homeRemoteDataSource.deleteOldTasks();
      return right(null);
    } catch (e) {
      return left(
        Failure(
          message: StringsManager.operationNotAllowed.tr(),
        ),
      );
    }
  }
}
