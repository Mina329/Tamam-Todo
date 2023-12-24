import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/utils/app_router.dart';
import 'package:todo/core/utils/assets_manager.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/core/widgets/custom_sliver_sizedbox.dart';
import 'package:todo/features/auth/presentation/view/widgets/custom_login_button.dart';
import 'package:todo/features/auth/presentation/view/widgets/login_view.dart';
import 'package:todo/features/auth/presentation/view/widgets/register_view.dart';

class AuthViewBody extends StatefulWidget {
  const AuthViewBody({super.key});

  @override
  State<AuthViewBody> createState() => _AuthViewBodyState();
}

class _AuthViewBodyState extends State<AuthViewBody> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverSizedBox(
          height: 80.h,
        ),
        SliverToBoxAdapter(
          child: isLogin ? const LoginView() : const RegisterView(),
        ),
        const SliverToBoxAdapter(
          child: Divider(),
        ),
        SliverSizedBox(
          height: 30.h,
        ),
        SliverToBoxAdapter(
          child: CustomLoginButton(
            asset: AssetsManager.googleIcon,
            text: StringsManager.loginWithGoogle.tr(),
            onPressed: () {
              GoRouter.of(context).push(AppRouter.kHomeView);
            },
          ),
        ),
        SliverSizedBox(
          height: 20.h,
        ),
        SliverToBoxAdapter(
          child: CustomLoginButton(
            asset: AssetsManager.facebookIcon,
            text: StringsManager.loginWithFacebook.tr(),
            onPressed: () {
              GoRouter.of(context).push(AppRouter.kHomeView);
            },
          ),
        ),
        SliverSizedBox(
          height: 50.h,
        ),
        SliverToBoxAdapter(
          child: _loginRegisterSwitcher(context),
        ),
        SliverSizedBox(
          height: 30.h,
        ),
      ],
    );
  }

  Row _loginRegisterSwitcher(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isLogin
              ? StringsManager.dontHaveAccount.tr()
              : StringsManager.alreadyHaveAccount.tr(),
          style: Theme.of(context).textTheme.labelSmall,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isLogin = !isLogin;
            });
          },
          child: Text(
            isLogin ? StringsManager.register.tr() : StringsManager.login.tr(),
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white.withOpacity(
                          0.87,
                        )
                      : Colors.grey[900],
                ),
          ),
        )
      ],
    );
  }
}
