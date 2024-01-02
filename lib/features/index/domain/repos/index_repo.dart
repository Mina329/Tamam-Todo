import 'package:dartz/dartz.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/features/home/domain/entities/task.dart';

abstract class IndexRepo {
  Future<Either<Failure, List<TaskEntity>>> getTasksByDay(DateTime day);
}
