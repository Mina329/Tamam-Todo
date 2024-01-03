import 'package:dartz/dartz.dart';
import 'package:todo/core/use_cases/use_case.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/features/home/domain/entities/task.dart';
import 'package:todo/features/index/domain/repos/index_repo.dart';

class EditTaskUseCase extends UseCase<void, (TaskEntity, TaskEntity)> {
  final IndexRepo indexRepo;

  EditTaskUseCase({required this.indexRepo});

  @override
  Future<Either<Failure, void>> execute(
      [(TaskEntity, TaskEntity)? inputs]) async {
    return await indexRepo.editTask(oldTask: inputs!.$1, newTask: inputs.$2);
  }
}
