import 'package:dartz/dartz.dart';
import 'package:todo/core/use_cases/use_case.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/features/profile/domain/repos/profile_repo.dart';

class ChangeAccountPasswordUseCase extends UseCase<void, (String, String)> {
  final ProfileRepo profileRepo;

  ChangeAccountPasswordUseCase({required this.profileRepo});

  @override
  Future<Either<Failure, void>> execute([(String, String)? inputs]) async {
    return await profileRepo.changeAccountPassword(inputs!.$1, inputs.$2);
  }
}
