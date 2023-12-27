import 'package:dartz/dartz.dart';
import 'package:todo/core/use_cases/use_case.dart';
import 'package:todo/core/utils/failures.dart';
import 'package:todo/features/auth/domain/entities/user.dart';
import 'package:todo/features/auth/domain/repos/auth_repo.dart';

class LogInUserWithEmailAndPasswordUseCase extends UseCase<void, User> {
  final AuthRepo authRepo;

  LogInUserWithEmailAndPasswordUseCase({required this.authRepo});

  @override
  Future<Either<Failure, void>> execute([User? inputs]) async {
    return await authRepo.logInUserWithEmailAndPassword(inputs!);
  }
}
