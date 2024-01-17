import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tamam_account_delete/core/failure.dart';
import 'package:tamam_account_delete/domain/repos/home_repo.dart';

class HomeRepoImpl extends HomeRepo {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final FirebaseStorage firebaseStorage;
  HomeRepoImpl({
    required this.firebaseStorage,
    required this.firebaseAuth,
    required this.firestore,
  });

  @override
  Future<Either<Failure, void>> deleteAccountWithEmailAndPassword(
      String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      for (String subcollectionName in ['categories', 'tasks', 'focus']) {
        CollectionReference subcollectionRef = firestore
            .collection('users')
            .doc(firebaseAuth.currentUser!.uid)
            .collection(subcollectionName);
        QuerySnapshot subcollectionSnapshot = await subcollectionRef.get();
        for (DocumentSnapshot subcollectionDoc in subcollectionSnapshot.docs) {
          await subcollectionDoc.reference.delete();
        }
      }
      await firestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .delete();
      try {
        await firebaseStorage
            .ref("profile_photo_${firebaseAuth.currentUser!.uid}")
            .delete();
        // ignore: empty_catches
      } catch (e) {}
      await firebaseAuth.currentUser!.delete();
      return right(null);
    } on FirebaseAuthException catch (e) {
      return left(
        Failure(message: e.code),
      );
    } catch (e) {
      return left(
        Failure(message: 'Something went wrong'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccountWithGoogle() async {
    try {
      await firebaseAuth.signInWithPopup(GoogleAuthProvider());
      for (String subcollectionName in ['categories', 'tasks', 'focus']) {
        CollectionReference subcollectionRef = firestore
            .collection('users')
            .doc(firebaseAuth.currentUser!.uid)
            .collection(subcollectionName);
        QuerySnapshot subcollectionSnapshot = await subcollectionRef.get();
        for (DocumentSnapshot subcollectionDoc in subcollectionSnapshot.docs) {
          await subcollectionDoc.reference.delete();
        }
      }
      await firestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .delete();
      try {
        await firebaseStorage
            .ref("profile_photo_${firebaseAuth.currentUser!.uid}")
            .delete();
        // ignore: empty_catches
      } catch (e) {}
      await firebaseAuth.currentUser!.delete();
      return right(null);
    } on FirebaseAuthException catch (e) {
      return left(
        Failure(message: e.code),
      );
    } catch (e) {
      return left(
        Failure(message: e.toString()),
      );
    }
  }
}
