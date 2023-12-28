import 'package:dartz/dartz.dart';
import 'package:todo/core/use_cases/use_case.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/features/auth/domain/entities/user.dart';
import 'package:todo/features/auth/domain/repos/auth_repo.dart';

class LogInUserWithGoogleUseCase extends UseCase<void, UserData> {
  final AuthRepo authRepo;

  LogInUserWithGoogleUseCase({required this.authRepo});

  @override
  Future<Either<Failure, void>> execute([UserData? inputs]) async {
    return await authRepo.logInUserWithGoogle();
  }
}
