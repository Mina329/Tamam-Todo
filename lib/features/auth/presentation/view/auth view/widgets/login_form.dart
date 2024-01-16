import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/utils/app_router.dart';
import 'package:todo/core/utils/strings_manager.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
    required this.formKey,
    required this.onSavedEmail,
    required this.onSavedPassword,
  });
  final GlobalKey<FormState> formKey;
  final Function(String?) onSavedEmail;
  final Function(String?) onSavedPassword;
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool obsecure = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringsManager.email.tr(),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(
            height: 10.h,
          ),
          TextFormField(
            style: Theme.of(context).textTheme.headlineSmall,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(15),
              hintText: StringsManager.enterEmail.tr(),
            ),
            validator: _buildEmailValidation,
            onSaved: widget.onSavedEmail,
          ),
          SizedBox(
            height: 25.h,
          ),
          Text(
            StringsManager.password.tr(),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(
            height: 10.h,
          ),
          TextFormField(
            style: Theme.of(context).textTheme.headlineSmall,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(15),
              hintText: StringsManager.enterPassword.tr(),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obsecure = !obsecure;
                  });
                },
                icon: Icon(
                  obsecure ? Icons.visibility_off : Icons.remove_red_eye,
                  size: 24.sp,
                ),
              ),
            ),
            obscureText: obsecure,
            validator: _buildPasswordValidation,
            onSaved: widget.onSavedPassword,
          ),
          SizedBox(
            height: 10.h,
          ),
          GestureDetector(
            onTap: () {
              GoRouter.of(context).push(AppRouter.kForgetPasswordView);
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                StringsManager.forgotPassword.tr(),
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white.withOpacity(
                              0.87,
                            )
                          : Colors.grey[900],
                    ),
              ),
            ),
          )
        ],
      ),
    );
  }

  String? _buildPasswordValidation(value) {
    if (value == null || value.isEmpty) {
      return StringsManager.passwordValidation.tr();
    }
    return null;
  }

  String? _buildEmailValidation(value) {
    RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if (value == null || value.isEmpty || !emailRegex.hasMatch(value)) {
      return StringsManager.emailValidation.tr();
    }
    return null;
  }
}
