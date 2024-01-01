import 'package:dartz/dartz.dart';
import 'package:todo/core/use_cases/use_case.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/features/home/domain/entities/task.dart';
import 'package:todo/features/index/domain/repos/index_repo.dart';

class SearchTaskUseCase extends UseCase<List<TaskEntity>,
    (String searchText, List<TaskEntity> tasks)> {
  final IndexRepo indexRepo;

  SearchTaskUseCase({required this.indexRepo});

  @override
  Future<Either<Failure, List<TaskEntity>>> execute(
      [(String, List<TaskEntity>)? inputs]) async {
    return await indexRepo.searchTask(inputs!.$1, inputs.$2);
  }
}
