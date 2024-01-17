import 'package:dartz/dartz.dart';
import 'package:tamam_account_delete/core/failure.dart';

abstract class UseCase<T, Inputs> {
  Future<Either<Failure, T>> execute([Inputs inputs]);
}
