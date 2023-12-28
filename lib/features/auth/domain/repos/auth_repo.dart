import 'package:dartz/dartz.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/features/auth/domain/entities/user.dart';

abstract class AuthRepo {
  Future<Either<Failure, void>> registerUserWithEmailAndPassword(UserData user);
  Future<Either<Failure, void>> logInUserWithEmailAndPassword(UserData user);
  Future<Either<Failure, void>> logInUserWithGoogle();
  Future<Either<Failure, void>> verifyEmail(String email);
  Future<Either<Failure, void>> forgetPassword(String email);
}
