import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/core/errors/firebase_auth_failure.dart';
import 'package:todo/features/auth/domain/entities/user.dart';
import 'package:todo/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  final FirebaseAuth _firebaseAuth;

  AuthRepoImpl({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<Either<Failure, void>> registerUserWithEmailAndPassword(
      UserData user) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        await firebaseUser.updateDisplayName(user.name);
        await firebaseUser.reload();
      }
      return right(null);
    } on FirebaseAuthException catch (e) {
      return left(
        FirebaseAuthFailure.fromFirebaseAuthException(e),
      );
    }
  }

  @override
  Future<Either<Failure, void>> verifyEmail() async {
    try {
      _firebaseAuth.currentUser!.sendEmailVerification();
      return right(null);
    } on FirebaseAuthException catch (e) {
      return left(
        FirebaseAuthFailure.fromFirebaseAuthException(e),
      );
    }
  }

  @override
  Future<Either<Failure, UserCredential>> logInUserWithEmailAndPassword(
      UserData user) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      return right(userCredential);
    } on FirebaseAuthException catch (e) {
      return left(
        FirebaseAuthFailure.fromFirebaseAuthException(e),
      );
    }
  }

  @override
  Future<Either<Failure, void>> logInUserWithGoogle() async {
    try {
      GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      await _firebaseAuth.signInWithProvider(googleAuthProvider);
      return right(null);
    } on FirebaseAuthException catch (e) {
      return left(
        FirebaseAuthFailure.fromFirebaseAuthException(e),
      );
    }
  }

  @override
  Future<Either<Failure, void>> forgetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return right(null);
    } on FirebaseAuthException catch (e) {
      return left(
        FirebaseAuthFailure.fromFirebaseAuthException(e),
      );
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return right(null);
    } on FirebaseAuthException catch (e) {
      return left(
        FirebaseAuthFailure.fromFirebaseAuthException(e),
      );
    }
  }
}
