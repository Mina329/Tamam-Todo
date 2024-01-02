import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/features/home/domain/entities/task.dart';
import 'package:todo/features/index/data/data_sources/index_local_data_source/index_local_data_source.dart';
import 'package:todo/features/index/data/data_sources/index_remote_data_source/index_remote_data_source.dart';
import 'package:todo/features/index/domain/repos/index_repo.dart';

class IndexRepoImpl extends IndexRepo {
  final IndexRemoteDataSource indexRemoteDataSource;
  final IndexLocalDataSource indexLocalDataSource;

  IndexRepoImpl(
      {required this.indexRemoteDataSource,
      required this.indexLocalDataSource});

  @override
  Future<Either<Failure, List<TaskEntity>>> getTasksByDay(DateTime day) async {
    try {
      var tasks = indexLocalDataSource.getTasksByDay(day);
      if (tasks.isNotEmpty) {
        return right(tasks);
      }
      var remoteTasks = await indexRemoteDataSource.getTasksByDay(day);
      return right(remoteTasks);
    } catch (e) {
      return left(
        Failure(
          message: StringsManager.operationNotAllowed.tr(),
        ),
      );
    }
  }
}
