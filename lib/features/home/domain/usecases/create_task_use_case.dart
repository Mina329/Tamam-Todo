import 'package:dartz/dartz.dart';
import 'package:todo/core/use_cases/use_case.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/features/home/domain/entities/task.dart';
import 'package:todo/features/home/domain/repos/home_repo.dart';

class CreateTaskUseCase extends UseCase<void, TaskEntity> {
  final HomeRepo homeRepo;

  CreateTaskUseCase({required this.homeRepo});

  @override
  Future<Either<Failure, void>> execute([TaskEntity? inputs]) async {
    return await homeRepo.createTask(inputs!);
  }
}
