import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/core/errors/firebase_auth_failure.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/features/profile/data/data_sources/profile_local_data_source/profile_local_data_source.dart';
import 'package:todo/features/profile/data/data_sources/profile_remote_data_source/profile_remote_data_source.dart';
import 'package:todo/features/profile/domain/repos/profile_repo.dart';

class ProfileRepoImpl extends ProfileRepo {
  final ProfileRemoteDataSource profileRemoteDataSource;

  final ProfileLocalDataSource profileLocalDataSource;
  ProfileRepoImpl(
      {required this.profileLocalDataSource,
      required this.profileRemoteDataSource});
  @override
  Future<Either<Failure, void>> changeAccountName(String name) async {
    try {
      await profileRemoteDataSource.changeAccountName(name);
      return right(null);
    } catch (e) {
      return left(
        Failure(
          message: StringsManager.operationNotAllowed.tr(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> changeAccountPassword(
      String oldPassword, String newPassword) async {
    try {
      await profileRemoteDataSource.changeAccountPassword(
          oldPassword, newPassword);
      return right(null);
    } on FirebaseAuthException catch (e) {
      return left(
        FirebaseAuthFailure.fromFirebaseAuthException(e),
      );
    } catch (e) {
      return left(
        Failure(
          message: StringsManager.operationNotAllowed.tr(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> changeAccountPhoto(File image) async {
    try {
      await profileRemoteDataSource.changeAccountPhoto(image);
      return right(null);
    } catch (e) {
      return left(
        Failure(
          message: StringsManager.operationNotAllowed.tr(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount(String? password) async {
    try {
      await profileRemoteDataSource.deleteAccount(password);
      await profileLocalDataSource.deleteAccount();
      return right(null);
    } on FirebaseAuthException catch (e) {
      return left(
        FirebaseAuthFailure.fromFirebaseAuthException(e),
      );
    } catch (e) {
      return left(
        Failure(
          message: e.toString(),
        ),
      );
    }
  }
}
