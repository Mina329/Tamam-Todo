import 'package:dartz/dartz.dart';
import 'package:todo/core/use_cases/use_case.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/features/auth/domain/repos/auth_repo.dart';

class VerifyEmailUseCase extends UseCase<void, void> {
  final AuthRepo authRepo;

  VerifyEmailUseCase({required this.authRepo});

  @override
  Future<Either<Failure, void>> execute([void inputs]) async {
    return await authRepo.verifyEmail();
  }
}
