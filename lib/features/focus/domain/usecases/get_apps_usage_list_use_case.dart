import 'package:app_usage/app_usage.dart';
import 'package:dartz/dartz.dart';
import 'package:todo/core/use_cases/use_case.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/features/focus/domain/repos/focus_repo.dart';

class GetAppsUsageListUseCase extends UseCase<List<AppUsageInfo>, void> {
  final FocusRepo focusRepo;

  GetAppsUsageListUseCase({required this.focusRepo});

  @override
  Future<Either<Failure, List<AppUsageInfo>>> execute([void inputs]) async {
    return await focusRepo.getAppsUsageList();
  }
}
