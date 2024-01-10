import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:todo/features/profile/data/data_sources/profile_remote_data_source/profile_remote_data_source.dart';

class ProfileRemoteDataSourceImpl extends ProfileRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage;
  ProfileRemoteDataSourceImpl(
      {required this.firebaseStorage, required this.firebaseAuth});
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
}
