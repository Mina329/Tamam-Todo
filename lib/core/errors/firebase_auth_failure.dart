import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/core/utils/strings_manager.dart';

class FirebaseAuthFailure extends Failure {
  FirebaseAuthFailure({required super.message});

  factory FirebaseAuthFailure.fromFirebaseAuthException(
      FirebaseAuthException exception) {
    switch (exception.code) {
      case 'email-already-in-use':
        return FirebaseAuthFailure(
            message: StringsManager.emailAlreadyInUse.tr());
      case 'invalid-email':
        return FirebaseAuthFailure(message: StringsManager.invalidEmail.tr());
      case 'operation-not-allowed:':
        return FirebaseAuthFailure(
            message: StringsManager.operationNotAllowed.tr());
      case 'weak-password':
        return FirebaseAuthFailure(message: StringsManager.weakPassword.tr());
      case 'user-disabled':
        return FirebaseAuthFailure(message: StringsManager.userDisabled.tr());
      case 'user-not-found':
        return FirebaseAuthFailure(
            message: StringsManager.userNotRegistered.tr());
      case 'wrong-password':
        return FirebaseAuthFailure(message: StringsManager.wrongPassword.tr());
      case 'invalid-credential':
        return FirebaseAuthFailure(
            message: StringsManager.wrongCredentials.tr());
      case 'account-exists-with-different-credential':
        return FirebaseAuthFailure(
            message: StringsManager.accountExistsWithDifferentCredential.tr());
      default:
        return FirebaseAuthFailure(message: exception.code);
    }
  }
}
