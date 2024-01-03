import 'package:dartz/dartz.dart';
import 'package:todo/core/use_cases/use_case.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/features/index/domain/repos/index_repo.dart';

class ChangeTaskStatusUseCase extends UseCase<void, (String,String)> {
  final IndexRepo indexRepo;

  ChangeTaskStatusUseCase({required this.indexRepo});

  @override
  Future<Either<Failure, void>> execute([(String,String)? inputs]) async {
    return await indexRepo.changeTaskStatus(status: inputs!.$1,taskId: inputs.$2);
  }
}
