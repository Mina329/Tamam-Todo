import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/features/auth/data/repos/auth_repo_impl.dart';
import 'package:todo/features/auth/domain/repos/auth_repo.dart';
import 'package:todo/features/auth/domain/usecases/forget_password_use_case.dart';
import 'package:todo/features/auth/domain/usecases/log_in_user_with_email_and_password_use_case.dart';
import 'package:todo/features/auth/domain/usecases/log_in_user_with_google_use_case.dart';
import 'package:todo/features/auth/domain/usecases/register_user_with_email_and_password_use_case.dart';
import 'package:todo/features/auth/domain/usecases/sign_out_use_case.dart';
import 'package:todo/features/auth/domain/usecases/verify_email_use_case.dart';
import 'package:todo/features/focus/data/data_sources/focus_local_data_source/focus_local_data_source.dart';
import 'package:todo/features/focus/data/data_sources/focus_local_data_source/focus_local_data_source_impl.dart';
import 'package:todo/features/focus/data/data_sources/focus_remote_data_source/focus_remote_data_source.dart';
import 'package:todo/features/focus/data/data_sources/focus_remote_data_source/focus_remote_data_source_impl.dart';
import 'package:todo/features/focus/data/repos/focus_repo_impl.dart';
import 'package:todo/features/focus/domain/repos/focus_repo.dart';
import 'package:todo/features/focus/domain/usecases/add_time_for_today_use_case.dart';
import 'package:todo/features/focus/domain/usecases/get_focused_time_use_case.dart';
import 'package:todo/features/home/data/data_source/local_data_source/home_local_data_source.dart';
import 'package:todo/features/home/data/data_source/local_data_source/home_local_data_source_impl.dart';
import 'package:todo/features/home/data/data_source/remote_data_source/home_remote_data_source.dart';
import 'package:todo/features/home/data/data_source/remote_data_source/home_remote_data_source_impl.dart';
import 'package:todo/features/home/data/repos/home_repo_impl.dart';
import 'package:todo/features/home/domain/repos/home_repo.dart';
import 'package:todo/features/home/domain/usecases/create_category_use_case.dart';
import 'package:todo/features/home/domain/usecases/create_task_use_case.dart';
import 'package:todo/features/home/domain/usecases/delete_category_use_case.dart';
import 'package:todo/features/home/domain/usecases/get_all_categories_use_case.dart';
import 'package:todo/features/index/data/data_sources/index_local_data_source/index_local_data_source.dart';
import 'package:todo/features/index/data/data_sources/index_local_data_source/index_local_data_source_impl.dart';
import 'package:todo/features/index/data/data_sources/index_remote_data_source/index_remote_data_source.dart';
import 'package:todo/features/index/data/data_sources/index_remote_data_source/index_remote_data_source_impl.dart';
import 'package:todo/features/index/data/repos/index_repo_impl.dart';
import 'package:todo/features/index/domain/repos/index_repo.dart';
import 'package:todo/features/index/domain/usecases/change_task_status_use_case.dart';
import 'package:todo/features/index/domain/usecases/delete_task_use_case.dart';
import 'package:todo/features/index/domain/usecases/edit_task_use_case.dart';
import 'package:todo/features/index/domain/usecases/get_task_by_day_use_case.dart';

final getIt = GetIt.instance;
void setupServiceLocator() {
  getIt.registerSingleton<FirebaseAuth>(
    FirebaseAuth.instance,
  );
  getIt.registerSingleton<FirebaseFirestore>(
    FirebaseFirestore.instance,
  );
  getIt.registerSingleton<HomeLocalDataSource>(
    HomeLocalDataSourceImpl(),
  );
  getIt.registerSingleton<IndexLocalDataSource>(
    IndexLocalDataSourceImpl(),
  );
  getIt.registerSingleton<FocusLocalDataSource>(
    FocusLocalDataSourceImpl(),
  );
  getIt.registerSingleton<HomeRemoteDataSource>(
    HomeRemoteDataSourceImpl(
      firebaseAuth: getIt.get<FirebaseAuth>(),
      firestore: getIt.get<FirebaseFirestore>(),
    ),
  );
  getIt.registerSingleton<IndexRemoteDataSource>(
    IndexRemoteDataSourceImpl(
      firebaseAuth: getIt.get<FirebaseAuth>(),
      firestore: getIt.get<FirebaseFirestore>(),
    ),
  );
  getIt.registerSingleton<FocusRemoteDataSource>(
    FocusRemoteDataSourceImpl(
      firebaseAuth: getIt.get<FirebaseAuth>(),
      firestore: getIt.get<FirebaseFirestore>(),
    ),
  );
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(
      firebaseAuth: getIt.get<FirebaseAuth>(),
    ),
  );
  getIt.registerSingleton<IndexRepo>(
    IndexRepoImpl(
      indexLocalDataSource: getIt.get<IndexLocalDataSource>(),
      indexRemoteDataSource: getIt.get<IndexRemoteDataSource>(),
    ),
  );
  getIt.registerSingleton<HomeRepo>(
    HomeRepoImpl(
      homeLocalDataSource: getIt.get<HomeLocalDataSource>(),
      homeRemoteDataSource: getIt.get<HomeRemoteDataSource>(),
    ),
  );
  getIt.registerSingleton<FocusRepo>(
    FocusRepoImpl(
      focusLocalDataSource: getIt.get<FocusLocalDataSource>(),
      focusRemoteDataSource: getIt.get<FocusRemoteDataSource>(),
    ),
  );
  getIt.registerSingleton<RegisterUserWithEmailAndPasswordUseCase>(
    RegisterUserWithEmailAndPasswordUseCase(
      authRepo: getIt.get<AuthRepo>(),
    ),
  );
  getIt.registerSingleton<LogInUserWithEmailAndPasswordUseCase>(
    LogInUserWithEmailAndPasswordUseCase(
      authRepo: getIt.get<AuthRepo>(),
    ),
  );
  getIt.registerSingleton<LogInUserWithGoogleUseCase>(
    LogInUserWithGoogleUseCase(
      authRepo: getIt.get<AuthRepo>(),
    ),
  );
  getIt.registerSingleton<ForgetPasswordUseCase>(
    ForgetPasswordUseCase(
      authRepo: getIt.get<AuthRepo>(),
    ),
  );
  getIt.registerSingleton<VerifyEmailUseCase>(
    VerifyEmailUseCase(
      authRepo: getIt.get<AuthRepo>(),
    ),
  );
  getIt.registerSingleton<SignOutUseCase>(
    SignOutUseCase(
      authRepo: getIt.get<AuthRepo>(),
    ),
  );
  getIt.registerSingleton<CreateCategoryUseCase>(
    CreateCategoryUseCase(
      homeRepo: getIt.get<HomeRepo>(),
    ),
  );
  getIt.registerSingleton<CreateTaskUseCase>(
    CreateTaskUseCase(
      homeRepo: getIt.get<HomeRepo>(),
    ),
  );
  getIt.registerSingleton<GetAllCategoriesUseCase>(
    GetAllCategoriesUseCase(
      homeRepo: getIt.get<HomeRepo>(),
    ),
  );
  getIt.registerSingleton<DeleteCategoryUseCase>(
    DeleteCategoryUseCase(
      homeRepo: getIt.get<HomeRepo>(),
    ),
  );
  getIt.registerSingleton<GetTaskByDayUseCase>(
    GetTaskByDayUseCase(
      indexRepo: getIt.get<IndexRepo>(),
    ),
  );
  getIt.registerSingleton<ChangeTaskStatusUseCase>(
    ChangeTaskStatusUseCase(
      indexRepo: getIt.get<IndexRepo>(),
    ),
  );
  getIt.registerSingleton<EditTaskUseCase>(
    EditTaskUseCase(
      indexRepo: getIt.get<IndexRepo>(),
    ),
  );
  getIt.registerSingleton<DeleteTaskUseCase>(
    DeleteTaskUseCase(
      indexRepo: getIt.get<IndexRepo>(),
    ),
  );
  getIt.registerSingleton<GetFocusedTimeUseCase>(
    GetFocusedTimeUseCase(
      focusRepo: getIt.get<FocusRepo>(),
    ),
  );
  getIt.registerSingleton<AddTimeForTodayUseCase>(
    AddTimeForTodayUseCase(
      focusRepo: getIt.get<FocusRepo>(),
    ),
  );
}
