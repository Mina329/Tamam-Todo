import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/features/auth/data/repos/auth_repo_impl.dart';
import 'package:todo/features/auth/domain/repos/auth_repo.dart';
import 'package:todo/features/auth/domain/usecases/register_user_with_email_and_password_use_case.dart';

final getIt = GetIt.instance;
void setupServiceLocator() {
  getIt.registerSingleton<FirebaseAuth>(
    FirebaseAuth.instance,
  );
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(
      firebaseAuth: getIt.get<FirebaseAuth>(),
    ),
  );
  getIt.registerSingleton<RegisterUserWithEmailAndPasswordUseCase>(
    RegisterUserWithEmailAndPasswordUseCase(
      authRepo: getIt.get<AuthRepo>(),
    ),
  );
}