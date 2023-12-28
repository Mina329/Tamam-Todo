import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/utils/app_router.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/core/widgets/custom_loading_animation.dart';
import 'package:todo/features/auth/domain/entities/user.dart';
import 'package:todo/features/auth/presentation/manager/log_in_user_with_email_and_password_cubit/log_in_user_with_email_and_password_cubit.dart';
import 'package:todo/features/auth/presentation/view/auth%20view/widgets/login_form.dart';

class LoginView extends StatefulWidget {
  const LoginView({
    super.key,
  });

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final GlobalKey<FormState> formKey;
  late String email;
  late String password;
  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringsManager.login.tr(),
          style: Theme.of(context).textTheme.displayMedium,
        ),
        SizedBox(
          height: 53.h,
        ),
        LoginForm(
          formKey: formKey,
          onSavedEmail: _onSavedEmail,
          onSavedPassword: _onSavedPassword,
        ),
        SizedBox(
          height: 70.h,
        ),
        BlocListener<LogInUserWithEmailAndPasswordCubit,
            LogInUserWithEmailAndPasswordState>(
          listener: (context, state) {
            if (state is LogInUserWithEmailAndPasswordLoading) {
              CustomLoadingAnimation.buildLoadingIndicator(context);
            } else if (state is LogInUserWithEmailAndPasswordFailure) {
              GoRouter.of(context).pop();
              Fluttertoast.showToast(
                msg: state.errMessage,
                toastLength: Toast.LENGTH_SHORT,
              );
            } else if (state is LogInUserWithEmailAndPasswordSuccess) {
              GoRouter.of(context).pop();
              GoRouter.of(context).push(AppRouter.kHomeView);
            }
          },
          child: ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                BlocProvider.of<LogInUserWithEmailAndPasswordCubit>(context)
                    .logInUserWithEmailAndPassword(
                  UserData(
                    email: email,
                    password: password,
                  ),
                );
              }
            },
            child: SizedBox(
              height: 48.h,
              width: double.infinity,
              child: Center(
                child: Text(
                  StringsManager.login.tr(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
      ],
    );
  }

  _onSavedPassword(password) {
    this.password = password;
  }

  _onSavedEmail(email) {
    this.email = email;
  }
}
