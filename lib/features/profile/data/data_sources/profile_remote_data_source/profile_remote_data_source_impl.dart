import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:todo/features/profile/data/data_sources/profile_remote_data_source/profile_remote_data_source.dart';

class ProfileRemoteDataSourceImpl extends ProfileRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage;
  final FirebaseFirestore firestore;
  ProfileRemoteDataSourceImpl(
      {required this.firestore,
      required this.firebaseStorage,
      required this.firebaseAuth});
  @override
  Future<void> changeAccountName(String name) async {
    await firebaseAuth.currentUser?.updateDisplayName(name);
    await firebaseAuth.currentUser?.reload();
  }

  @override
  Future<void> changeAccountPassword(
      String oldPassword, String newPassword) async {
    AuthCredential credential = EmailAuthProvider.credential(
        email: firebaseAuth.currentUser!.email!, password: oldPassword);
    await firebaseAuth.currentUser!.reauthenticateWithCredential(credential);
    await firebaseAuth.currentUser!.updatePassword(newPassword);
  }

  @override
  Future<void> changeAccountPhoto(File image) async {
    String imageName = "profile_photo_${firebaseAuth.currentUser!.uid}";
    Reference storageReference = firebaseStorage.ref().child(imageName);
    await storageReference.putFile(image);
    String imageURL = await storageReference.getDownloadURL();
    await firebaseAuth.currentUser!.updatePhotoURL(imageURL);
    await firebaseAuth.currentUser?.reload();
  }

  @override
  Future<void> deleteAccount(String? password) async {
    if (password == null) {
      await firebaseAuth.currentUser!.reauthenticateWithProvider(
        GoogleAuthProvider(),
      );
    } else {
      AuthCredential credential = EmailAuthProvider.credential(
          email: firebaseAuth.currentUser!.email!, password: password);
      await firebaseAuth.currentUser!.reauthenticateWithCredential(credential);
    }
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
    } catch (e) {}
    await firebaseAuth.currentUser!.delete();
  }
}
