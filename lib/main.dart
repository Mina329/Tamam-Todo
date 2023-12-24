import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/cache/cache_helper.dart';
import 'package:todo/core/cache/cache_keys_values.dart';
import 'package:todo/core/utils/app_router.dart';
import 'package:todo/core/utils/theme_manager.dart';

final ValueNotifier<ThemeMode> notifier = ValueNotifier(
    CacheData.getData(key: CacheKeys.kDARKMODE) == CacheValues.LIGHT
        ? ThemeMode.light
        : ThemeMode.dark);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheData.casheIntialization();
  await EasyLocalization.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
        Locale('fr'),
        Locale('de'),
        Locale('es'),
        Locale('hi'),
        Locale('zh'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => ValueListenableBuilder<ThemeMode>(
        valueListenable: notifier,
        builder: (context, value, child) {
          return MaterialApp.router(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            routerConfig: AppRouter.router,
            theme: ThemeManager.lightThemeData,
            darkTheme: ThemeManager.darkThemeData,
            themeMode: value,
          );
        },
      ),
    );
  }
}
