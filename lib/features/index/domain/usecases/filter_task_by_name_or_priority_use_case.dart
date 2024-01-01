import 'package:dartz/dartz.dart';
import 'package:todo/core/use_cases/use_case.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/features/home/domain/entities/task.dart';
import 'package:todo/features/index/domain/repos/index_repo.dart';

class FilterTaskByNameOrPriorityUseCase extends UseCase<List<TaskEntity>,
    (bool byName, bool byPriority, List<TaskEntity> tasks)> {
  final IndexRepo indexRepo;

  FilterTaskByNameOrPriorityUseCase({required this.indexRepo});

  @override
  Future<Either<Failure, List<TaskEntity>>> execute(
      [(bool, bool, List<TaskEntity>)? inputs]) async {
    return await indexRepo.filterTasksByNameOrPriority(
        inputs!.$1, inputs.$2, inputs.$3);
  }
}
