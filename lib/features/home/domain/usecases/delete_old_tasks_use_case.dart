import 'package:dartz/dartz.dart';
import 'package:todo/core/use_cases/use_case.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/features/home/domain/repos/home_repo.dart';

class DeleteOldTasksUseCase extends UseCase<void, void> {
  final HomeRepo homeRepo;

  DeleteOldTasksUseCase({required this.homeRepo});

  @override
  Future<Either<Failure, void>> execute([void inputs]) async {
    return await homeRepo.deleteOldTasks();
  }
}
