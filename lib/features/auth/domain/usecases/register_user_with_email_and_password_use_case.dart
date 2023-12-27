import 'package:dartz/dartz.dart';
import 'package:todo/core/use_cases/use_case.dart';
import 'package:todo/core/utils/failures.dart';
import 'package:todo/features/auth/domain/entities/user.dart';
import 'package:todo/features/auth/domain/repos/auth_repo.dart';

class RegisterUserWithEmailAndPasswordUseCase
    extends UseCase<void, User> {
  final AuthRepo authRepo;

  RegisterUserWithEmailAndPasswordUseCase({required this.authRepo});

  @override
  Future<Either<Failure, void>> execute([User? inputs]) async {
    return await authRepo.registerUserWithEmailAndPassword(inputs!);
  }
}
