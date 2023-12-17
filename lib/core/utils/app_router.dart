import 'package:go_router/go_router.dart';
import 'package:todo/features/auth/presentation/view/auth_view.dart';
import 'package:todo/features/onboarding/presentation/view/onboarding_view.dart';
import 'package:todo/features/splash/presentation/view/splash_view.dart';

abstract class AppRouter {
  static const kSplashView = '/';
  static const kOnboardingView = '/onboarding';
  static const kAuthView = '/auth';
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: kSplashView,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: kOnboardingView,
        builder: (context, state) => const OnboardingView(),
      ),
      GoRoute(
        path: kAuthView,
        builder: (context, state) => const AuthView(),
      ),
    ],
  );
}
