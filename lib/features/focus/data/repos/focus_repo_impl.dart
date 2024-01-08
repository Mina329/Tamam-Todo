import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/features/focus/data/data_sources/focus_local_data_source/focus_local_data_source.dart';
import 'package:todo/features/focus/data/data_sources/focus_remote_data_source/focus_remote_data_source.dart';
import 'package:todo/features/focus/domain/repos/focus_repo.dart';

class FocusRepoImpl extends FocusRepo {
  final FocusRemoteDataSource focusRemoteDataSource;
  final FocusLocalDataSource focusLocalDataSource;

  FocusRepoImpl(
      {required this.focusRemoteDataSource,
      required this.focusLocalDataSource});
  @override
  Future<Either<Failure, void>> addTimeForToday(int seconds) async {
    try {
      await focusRemoteDataSource.addTimeForToday(seconds);
      await focusLocalDataSource.addTimeForToday(seconds);
      return right(null);
    } catch (e) {
      return left(
        Failure(
          message: StringsManager.operationNotAllowed.tr(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, int>> getTimeForToday() async {
    try {
      int? localSeconds = focusLocalDataSource.getTimeForToday();
      if (localSeconds != null) {
        return right(localSeconds);
      }
      int remoteSeconds = await focusRemoteDataSource.getTimeForToday();
      return right(remoteSeconds);
    } catch (e) {
      return left(
        Failure(
          message: StringsManager.operationNotAllowed.tr(),
        ),
      );
    }
  }
}
