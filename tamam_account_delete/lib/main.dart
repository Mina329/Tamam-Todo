import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamam_account_delete/data/repos/home_repo_impl.dart';
import 'package:tamam_account_delete/domain/usecases/delete_account_with_email_and_password_use_case.dart';
import 'package:tamam_account_delete/domain/usecases/delete_account_with_google_use_case.dart';
import 'package:tamam_account_delete/presentation/managers/delete_account_with_email_and_password_cubit/delete_account_with_email_and_password_cubit.dart';
import 'package:tamam_account_delete/presentation/managers/delete_account_with_google_cubit/delete_account_with_google_cubit.dart';
import 'package:tamam_account_delete/presentation/view/home_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tamam',
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DeleteAccountWithEmailAndPasswordCubit(
              DeleteAccountWithEmailAndPasswordUseCase(
                homeRepo: HomeRepoImpl(
                  firebaseAuth: FirebaseAuth.instance,
                  firestore: FirebaseFirestore.instance,
                  firebaseStorage: FirebaseStorage.instance,
                ),
              ),
            ),
          ),
          BlocProvider(
            create: (context) => DeleteAccountWithGoogleCubit(
              DeleteAccountWithGoogleUseCase(
                homeRepo: HomeRepoImpl(
                  firebaseAuth: FirebaseAuth.instance,
                  firestore: FirebaseFirestore.instance,
                  firebaseStorage: FirebaseStorage.instance,
                ),
              ),
            ),
          ),
        ],
        child: const HomeView(),
      ),
    );
  }
}
