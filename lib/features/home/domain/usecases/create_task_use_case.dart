import 'package:dartz/dartz.dart';
import 'package:todo/core/use_cases/use_case.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/features/home/domain/repos/home_repo.dart';

class CreateTaskUseCase extends UseCase<void, Task> {
  final HomeRepo homeRepo;

  CreateTaskUseCase({required this.homeRepo});

  @override
  Future<Either<Failure, void>> execute([Task? inputs]) async {
    return await homeRepo.createTask(inputs!);
  }
}
