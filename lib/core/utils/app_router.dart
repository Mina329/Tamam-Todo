import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/utils/service_locator.dart';
import 'package:todo/features/auth/domain/usecases/forget_password_use_case.dart';
import 'package:todo/features/auth/domain/usecases/log_in_user_with_email_and_password_use_case.dart';
import 'package:todo/features/auth/domain/usecases/log_in_user_with_google_use_case.dart';
import 'package:todo/features/auth/domain/usecases/register_user_with_email_and_password_use_case.dart';
import 'package:todo/features/auth/domain/usecases/sign_out_use_case.dart';
import 'package:todo/features/auth/domain/usecases/verify_email_use_case.dart';
import 'package:todo/features/auth/presentation/manager/forget_password_cubit/forget_password_cubit.dart';
import 'package:todo/features/auth/presentation/manager/log_in_user_with_email_and_password_cubit/log_in_user_with_email_and_password_cubit.dart';
import 'package:todo/features/auth/presentation/manager/log_in_user_with_google_cubit/log_in_user_with_google_cubit.dart';
import 'package:todo/features/auth/presentation/manager/register_user_with_email_and_password_cubit/register_user_with_email_and_password_cubit.dart';
import 'package:todo/features/auth/presentation/manager/sign_out_cubit/sign_out_cubit.dart';
import 'package:todo/features/auth/presentation/manager/verify_email_cubit/verify_email_cubit.dart';
import 'package:todo/features/auth/presentation/view/auth%20view/auth_view.dart';
import 'package:todo/features/auth/presentation/view/email%20verify%20view/email_verify_view.dart';
import 'package:todo/features/auth/presentation/view/forget%20password%20view/forget_password_view.dart';
import 'package:todo/features/home/domain/usecases/create_category_use_case.dart';
import 'package:todo/features/home/domain/usecases/create_task_use_case.dart';
import 'package:todo/features/home/domain/usecases/get_all_categories_use_case.dart';
import 'package:todo/features/home/presentation/manager/create_category_cubit/create_category_cubit.dart';
import 'package:todo/features/home/presentation/manager/create_task_cubit/create_task_cubit.dart';
import 'package:todo/features/home/presentation/manager/get_categories_cubit/get_categories_cubit.dart';
import 'package:todo/features/home/presentation/view/create%20category%20view/create_category_view.dart';
import 'package:todo/features/home/presentation/view/home%20view/home_view.dart';
import 'package:todo/features/index/domain/usecases/get_task_by_day_use_case.dart';
import 'package:todo/features/index/presentation/manager/get_tasks_by_day_cubit/get_tasks_by_day_cubit.dart';
import 'package:todo/features/index/presentation/view/edit%20task%20view/edit_task_view.dart';
import 'package:todo/features/onboarding/presentation/view/onboarding_view.dart';
import 'package:todo/features/profile/presentation/view/settings%20view/settings_view.dart';
import 'package:todo/features/splash/presentation/view/splash_view.dart';

abstract class AppRouter {
  static const kSplashView = '/';
  static const kOnboardingView = '/onboarding';
  static const kAuthView = '/auth';
  static const kHomeView = '/home';
  static const kCreateCategoryView = '/create_category';
  static const kEditTaskView = '/edit_task';
  static const kSettingsView = '/settings';
  static const kForgetPasswordView = '/forget_password';
  static const kEmailVerifyView = '/email_verify';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: kSplashView,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: kOnboardingView,
        pageBuilder: (context, state) => screenTransition(
          state,
          const OnboardingView(),
        ),
      ),
      GoRoute(
        path: kAuthView,
        pageBuilder: (context, state) => screenTransition(
          state,
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => RegisterUserWithEmailAndPasswordCubit(
                  getIt.get<RegisterUserWithEmailAndPasswordUseCase>(),
                ),
              ),
              BlocProvider(
                create: (context) => LogInUserWithEmailAndPasswordCubit(
                  getIt.get<LogInUserWithEmailAndPasswordUseCase>(),
                ),
              ),
              BlocProvider(
                create: (context) => LogInUserWithGoogleCubit(
                  getIt.get<LogInUserWithGoogleUseCase>(),
                ),
              ),
            ],
            child: const AuthView(),
          ),
        ),
      ),
      GoRoute(
        path: kHomeView,
        pageBuilder: (context, state) => screenTransition(
          state,
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => GetCategoriesCubit(
                  getIt.get<GetAllCategoriesUseCase>(),
                )..getAllCategories(),
              ),
              BlocProvider(
                create: (context) => CreateTaskCubit(
                  getIt.get<CreateTaskUseCase>(),
                ),
              ),
              BlocProvider(
                create: (context) => GetTasksByDayCubit(
                  getIt.get<GetTaskByDayUseCase>(),
                )..getTaskByDay(
                    DateTime(DateTime.now().year, DateTime.now().month,
                        DateTime.now().day, 0, 0, 0),
                  ),
              ),
            ],
            child: const HomeView(),
          ),
        ),
      ),
      GoRoute(
        path: kCreateCategoryView,
        pageBuilder: (context, state) {
          GetCategoriesCubit cubit = state.extra as GetCategoriesCubit;
          return screenTransition(
            state,
            MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => CreateCategoryCubit(
                    getIt.get<CreateCategoryUseCase>(),
                  ),
                ),
                BlocProvider.value(value: cubit),
              ],
              child: const CreateCategoryView(),
            ),
          );
        },
      ),
      GoRoute(
        path: kEditTaskView,
        pageBuilder: (context, state) => screenTransition(
          state,
          const EditTaskView(),
        ),
      ),
      GoRoute(
        path: kSettingsView,
        pageBuilder: (context, state) => screenTransition(
          state,
          const SettingsView(),
        ),
      ),
      GoRoute(
        path: kForgetPasswordView,
        pageBuilder: (context, state) => screenTransition(
          state,
          BlocProvider(
            create: (context) => ForgetPasswordCubit(
              getIt.get<ForgetPasswordUseCase>(),
            ),
            child: const ForgetPasswordView(),
          ),
        ),
      ),
      GoRoute(
        path: kEmailVerifyView,
        pageBuilder: (context, state) => screenTransition(
          state,
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => VerifyEmailCubit(
                  getIt.get<VerifyEmailUseCase>(),
                ),
              ),
              BlocProvider(
                create: (context) => SignOutCubit(
                  getIt.get<SignOutUseCase>(),
                ),
              )
            ],
            child: const EmailVerifyView(),
          ),
        ),
      ),
    ],
  );
}

CustomTransitionPage<void> screenTransition(
    GoRouterState state, Widget screen) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: screen,
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
        child: child,
      );
    },
  );
}
