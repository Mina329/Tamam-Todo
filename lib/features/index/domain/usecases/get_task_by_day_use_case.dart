import 'package:dartz/dartz.dart';
import 'package:todo/core/use_cases/use_case.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/features/home/domain/entities/task.dart';
import 'package:todo/features/index/domain/repos/index_repo.dart';

class GetTaskByDayUseCase extends UseCase<List<TaskEntity>, DateTime> {
  final IndexRepo indexRepo;

  GetTaskByDayUseCase({required this.indexRepo});

  @override
  Future<Either<Failure, List<TaskEntity>>> execute([DateTime? inputs]) async {
    return await indexRepo.getTasksByDay(inputs!);
  }
}
