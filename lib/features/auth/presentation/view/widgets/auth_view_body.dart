import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        const SliverToBoxAdapter(
          child: CustomLoginButton(
            asset: AssetsManager.googleIcon,
            text: StringsManager.loginWithGoogle,
          ),
        ),
        SliverSizedBox(
          height: 20.h,
        ),
        const SliverToBoxAdapter(
          child: CustomLoginButton(
            asset: AssetsManager.facebookIcon,
            text: StringsManager.loginWithFacebook,
          ),
        ),
        SliverSizedBox(
          height: 50.h,
        ),
        SliverToBoxAdapter(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isLogin
                    ? StringsManager.dontHaveAccount
                    : StringsManager.alreadyHaveAccount,
                style: Theme.of(context).textTheme.labelSmall,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isLogin = !isLogin;
                  });
                },
                child: Text(
                  isLogin ? StringsManager.register : StringsManager.login,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: Colors.white.withOpacity(
                          0.87,
                        ),
                      ),
                ),
              )
            ],
          ),
        ),
        SliverSizedBox(
          height: 30.h,
        ),
      ],
    );
  }
}
