import 'package:dartz/dartz.dart';
import 'package:todo/core/use_cases/use_case.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/features/index/domain/repos/index_repo.dart';

class DeleteTaskUseCase extends UseCase<void, String> {
  final IndexRepo indexRepo;

  DeleteTaskUseCase({required this.indexRepo});

  @override
  Future<Either<Failure, void>> execute([String? inputs]) async {
    return await indexRepo.deleteTask(inputs!);
  }
}
