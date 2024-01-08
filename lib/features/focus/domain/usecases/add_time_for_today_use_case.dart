import 'package:dartz/dartz.dart';
import 'package:todo/core/use_cases/use_case.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/features/focus/domain/repos/focus_repo.dart';

class AddTimeForTodayUseCase extends UseCase<void, int> {
  final FocusRepo focusRepo;

  AddTimeForTodayUseCase({required this.focusRepo});

  @override
  Future<Either<Failure, void>> execute([int? inputs]) async {
    return await focusRepo.addTimeForToday(inputs!);
  }
}
