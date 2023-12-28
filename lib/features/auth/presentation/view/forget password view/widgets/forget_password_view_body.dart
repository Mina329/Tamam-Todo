import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/core/widgets/custom_loading_animation.dart';
import 'package:todo/core/widgets/custom_sliver_sizedbox.dart';
import 'package:todo/features/auth/presentation/manager/forget_password_cubit/forget_password_cubit.dart';
import 'package:todo/features/auth/presentation/view/forget%20password%20view/widgets/send_button.dart';

class ForgetPasswordViewBody extends StatefulWidget {
  const ForgetPasswordViewBody({super.key});

  @override
  State<ForgetPasswordViewBody> createState() => _ForgetPasswordViewBodyState();
}

class _ForgetPasswordViewBodyState extends State<ForgetPasswordViewBody> {
  final GlobalKey<FormFieldState<String>> forgetPassword =
      GlobalKey<FormFieldState<String>>();

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
                  GoRouter.of(context).pop();
                },
              ),
            ),
          ),
          SliverSizedBox(
            height: 40.h,
          ),
          SliverToBoxAdapter(
            child: Text(
              StringsManager.sendPasswordResetEmail.tr(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          SliverSizedBox(
            height: 20.h,
          ),
          SliverToBoxAdapter(
            child: BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
              listener: (context, state) {
                if (state is ForgetPasswordLoading) {
                  CustomLoadingAnimation.buildLoadingIndicator(context);
                } else if (state is ForgetPasswordFailure) {
                  GoRouter.of(context).pop();
                  Fluttertoast.showToast(
                    msg: state.errMessage,
                    toastLength: Toast.LENGTH_SHORT,
                  );
                } else if (state is ForgetPasswordSuccess) {
                  GoRouter.of(context).pop();
                  Fluttertoast.showToast(
                    msg: StringsManager.resetPassword.tr(),
                    toastLength: Toast.LENGTH_SHORT,
                  );
                }
              },
              child: TextFormField(
                key: forgetPassword,
                style: Theme.of(context).textTheme.headlineSmall,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(15),
                  label: Text(
                    StringsManager.email.tr(),
                  ),
                  hintText: StringsManager.email.tr(),
                ),
                validator: _buildEmailValidation,
                onSaved: (value) {
                  BlocProvider.of<ForgetPasswordCubit>(context)
                      .forgetPassword(value!);
                },
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: SendButton(forgetPassword: forgetPassword),
          ),
        ],
      ),
    );
  }

  String? _buildEmailValidation(value) {
    RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if (value == null || value.isEmpty || !emailRegex.hasMatch(value)) {
      return StringsManager.emailValidation.tr();
    }
    return null;
  }
}
