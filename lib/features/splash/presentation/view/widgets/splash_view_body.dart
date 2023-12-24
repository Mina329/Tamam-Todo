import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/utils/app_router.dart';
import 'package:todo/core/utils/assets_manager.dart';
import 'package:todo/core/utils/strings_manager.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    super.initState();
    _navigateToOnBoarding();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SvgPicture.asset(
          AssetsManager.logo,
          width: 113.w,
          height: 113.h,
        ),
        Text(
          StringsManager.appName.tr(),
          style: Theme.of(context).textTheme.displayLarge,
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  void _navigateToOnBoarding() async {
    await Future.delayed(
      const Duration(milliseconds: 500),
      () => GoRouter.of(context).go(AppRouter.kOnboardingView),
    );
  }
}
