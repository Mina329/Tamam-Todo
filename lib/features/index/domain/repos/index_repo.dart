import 'package:dartz/dartz.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/features/home/domain/entities/task.dart';

abstract class IndexRepo {
  Future<Either<Failure, List<TaskEntity>>> getTasksByDay(DateTime day);
  Future<Either<Failure, void>> changeTaskStatus(
      {required String status, required String taskId});
  Future<Either<Failure, void>> editTask(
      {required TaskEntity oldTask, required TaskEntity newTask});
  Future<Either<Failure, void>> deleteTask(String taskId);
}
