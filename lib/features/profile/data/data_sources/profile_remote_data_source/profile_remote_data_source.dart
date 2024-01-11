import 'dart:io';

abstract class ProfileRemoteDataSource {
  Future<void> changeAccountName(String name);
  Future<void> changeAccountPassword(String oldPassword, String newPassword);
  Future<void> changeAccountPhoto(File image);
  Future<void> deleteAccount(String? password);
}
