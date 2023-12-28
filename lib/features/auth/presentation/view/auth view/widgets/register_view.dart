import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/core/widgets/custom_loading_animation.dart';
import 'package:todo/features/auth/domain/entities/user.dart';
import 'package:todo/features/auth/presentation/manager/register_user_with_email_and_password_cubit/register_user_with_email_and_password_cubit.dart';
import 'package:todo/features/auth/presentation/view/auth%20view/widgets/register_form.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final GlobalKey<FormState> formKey;
  late String name;
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
          StringsManager.register.tr(),
          style: Theme.of(context).textTheme.displayMedium,
        ),
        SizedBox(
          height: 30.h,
        ),
        RegisterForm(
          formKey: formKey,
          onSavedName: onSavedName,
          onSavedEmail: onSavedEmail,
          onSavedPassword: onSavedPassword,
        ),
        SizedBox(
          height: 50.h,
        ),
        BlocListener<RegisterUserWithEmailAndPasswordCubit,
            RegisterUserWithEmailAndPasswordState>(
          listener: (context, state) {
            if (state is RegisterUserWithEmailAndPasswordLoading) {
              CustomLoadingAnimation.buildLoadingIndicator(context);
            } else if (state is RegisterUserWithEmailAndPasswordFailure) {
              GoRouter.of(context).pop();
              Fluttertoast.showToast(
                msg: state.errMessage,
                toastLength: Toast.LENGTH_SHORT,
              );
            } else if (state is RegisterUserWithEmailAndPasswordSuccess) {
              GoRouter.of(context).pop();
              Fluttertoast.showToast(
                msg: StringsManager.userRegisteredSuccessfully.tr(),
                toastLength: Toast.LENGTH_SHORT,
              );
            }
          },
          child: ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                BlocProvider.of<RegisterUserWithEmailAndPasswordCubit>(context)
                    .registerUserWithEmailAndPassword(
                  UserData(
                    name: name,
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
                  StringsManager.register.tr(),
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
          height: 10.h,
        ),
      ],
    );
  }

  onSavedPassword(password) {
    this.password = password;
  }

  onSavedEmail(email) {
    this.email = email;
  }

  onSavedName(name) {
    this.name = name;
  }
}
