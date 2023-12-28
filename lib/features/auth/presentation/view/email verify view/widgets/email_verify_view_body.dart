import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/utils/app_router.dart';
import 'package:todo/core/utils/service_locator.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/core/widgets/custom_loading_animation.dart';
import 'package:todo/core/widgets/custom_sliver_sizedbox.dart';
import 'package:todo/features/auth/presentation/manager/verify_email_cubit/verify_email_cubit.dart';
import 'package:todo/features/auth/presentation/view/email%20verify%20view/widgets/send_email_verify.dart';

class EmailVerifyBody extends StatefulWidget {
  const EmailVerifyBody({super.key});

  @override
  State<EmailVerifyBody> createState() => _EmailVerifyBodyState();
}

class _EmailVerifyBodyState extends State<EmailVerifyBody> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer =
        Timer.periodic(const Duration(seconds: 3), (_) => checkEmailVerified());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomScrollView(
        slivers: [
          SliverSizedBox(
            height: 60.h,
          ),
          SliverToBoxAdapter(
            child: Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                ),
                onPressed: () {
                  getIt.get<FirebaseAuth>().signOut();
                  GoRouter.of(context).go(AppRouter.kAuthView);
                },
              ),
            ),
          ),
          SliverSizedBox(
            height: 40.h,
          ),
          SliverToBoxAdapter(
            child: Text(
              StringsManager.yourEmailIsNotVerified.tr(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: BlocListener<VerifyEmailCubit, VerifyEmailState>(
              listener: (context, state) {
                if (state is VerifyEmailLoading) {
                  CustomLoadingAnimation.buildLoadingIndicator(context);
                } else if (state is VerifyEmailFailure) {
                  GoRouter.of(context).pop();
                  Fluttertoast.showToast(
                    msg: state.errMessage,
                    toastLength: Toast.LENGTH_SHORT,
                  );
                } else if (state is VerifyEmailSuccess) {
                  GoRouter.of(context).pop();
                  Fluttertoast.showToast(
                    msg: StringsManager.verificationEmail.tr(),
                    toastLength: Toast.LENGTH_SHORT,
                  );
                }
              },
              child: const SendVerifyEmail(),
            ),
          ),
        ],
      ),
    );
  }

  checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();

    if (FirebaseAuth.instance.currentUser!.emailVerified && context.mounted) {
      GoRouter.of(context).go(AppRouter.kHomeView);
      timer?.cancel();
    }
  }
}
