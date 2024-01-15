import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/core/cache/cache_helper.dart';
import 'package:todo/core/cache/cache_keys_values.dart';
import 'package:todo/core/database/database.dart';
import 'package:todo/core/notifications/local_notification.dart';
import 'package:todo/core/utils/app_router.dart';
import 'package:todo/core/utils/service_locator.dart';
import 'package:todo/core/utils/theme_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final ValueNotifier<ThemeMode> notifier = ValueNotifier(
    CacheData.getData(key: CacheKeys.kDARKMODE) == CacheValues.LIGHT
        ? ThemeMode.light
        : ThemeMode.dark);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait<void>([
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ),
    LocalNotification.init(),
    CacheData.casheIntialization(),
    EasyLocalization.ensureInitialized(),
    Hive.initFlutter(),
  ]);
  await setupDataBase();
  setupServiceLocator();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => EasyLocalization(
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
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: LocalNotification.onActionReceivedMethod,
      onNotificationCreatedMethod:
          LocalNotification.onNotificationCreatedMethod,
      onDismissActionReceivedMethod:
          LocalNotification.onDismissActionReceivedMethod,
      onNotificationDisplayedMethod:
          LocalNotification.onNotificationDisplayedMethod,
    );
    super.initState();
  }

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
