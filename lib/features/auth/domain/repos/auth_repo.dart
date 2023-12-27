import 'package:dartz/dartz.dart';
import 'package:todo/core/utils/failures.dart';
import 'package:todo/features/auth/domain/entities/user.dart';

abstract class AuthRepo {
  Future<Either<Failure, void>> registerUserWithEmailAndPassword(User user);
  Future<Either<Failure, void>> logInUserWithEmailAndPassword(User user);
  Future<Either<Failure, void>> verifyEmail(String email);
}
