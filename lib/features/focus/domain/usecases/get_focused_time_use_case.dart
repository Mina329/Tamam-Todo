import 'package:dartz/dartz.dart';
import 'package:todo/core/use_cases/use_case.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/features/focus/domain/repos/focus_repo.dart';

class GetFocusedTimeUseCase extends UseCase<int, void> {
  final FocusRepo focusRepo;

  GetFocusedTimeUseCase({required this.focusRepo});

  @override
  Future<Either<Failure, int>> execute([void inputs]) async {
    return await focusRepo.getTimeForToday();
  }
}
