import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/core/use_cases/use_case.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/features/auth/domain/entities/user.dart';
import 'package:todo/features/auth/domain/repos/auth_repo.dart';

class LogInUserWithEmailAndPasswordUseCase
    extends UseCase<UserCredential, UserData> {
  final AuthRepo authRepo;

  LogInUserWithEmailAndPasswordUseCase({required this.authRepo});

  @override
  Future<Either<Failure, UserCredential>> execute([UserData? inputs]) async {
    return await authRepo.logInUserWithEmailAndPassword(inputs!);
  }
}
