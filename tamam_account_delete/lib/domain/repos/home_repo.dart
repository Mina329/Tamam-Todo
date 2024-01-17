import 'package:dartz/dartz.dart';
import 'package:tamam_account_delete/core/failure.dart';

abstract class HomeRepo {
  Future<Either<Failure, void>> deleteAccountWithEmailAndPassword(
      String email, String password);
  Future<Either<Failure, void>> deleteAccountWithGoogle();
}
