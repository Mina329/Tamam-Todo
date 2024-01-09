import 'package:app_usage/app_usage.dart';
import 'package:dartz/dartz.dart';
import 'package:todo/core/errors/failures.dart';

abstract class FocusRepo {
  Future<Either<Failure, void>> addTimeForToday(int seconds);
  Future<Either<Failure, int>> getTimeForToday();
  Future<Either<Failure, List<AppUsageInfo>>> getAppsUsageList();
}
