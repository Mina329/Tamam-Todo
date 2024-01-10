import 'package:dartz/dartz.dart';
import 'package:todo/core/use_cases/use_case.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/features/profile/domain/repos/profile_repo.dart';

class ChangeAccountNameUseCase extends UseCase<void, String> {
  final ProfileRepo profileRepo;

  ChangeAccountNameUseCase({required this.profileRepo});

  @override
  Future<Either<Failure, void>> execute([String? inputs]) async {
    return await profileRepo.changeAccountName(inputs!);
  }
}
