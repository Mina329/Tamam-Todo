import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:todo/core/errors/failures.dart';

abstract class ProfileRepo {
  Future<Either<Failure, void>> changeAccountName(String name);
  Future<Either<Failure, void>> changeAccountPassword(
      String oldPassword, String newPassword);
  Future<Either<Failure, void>> changeAccountPhoto(File image);
  Future<Either<Failure, void>> deleteAccount(String? password);
}
