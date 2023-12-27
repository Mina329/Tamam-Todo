import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/utils/strings_manager.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    super.key,
    required this.formKey,
    required this.onSavedName,
    required this.onSavedEmail,
    required this.onSavedPassword,
  });
  final GlobalKey<FormState> formKey;
  final Function(String?) onSavedName;
  final Function(String?) onSavedEmail;
  final Function(String?) onSavedPassword;
  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late final GlobalKey<FormFieldState<String>> _confirmPassword;
  String password = '';
  @override
  void initState() {
    super.initState();
    _confirmPassword = GlobalKey<FormFieldState<String>>();
  }

  bool obsecure = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringsManager.name.tr(),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(
            height: 10.h,
          ),
          TextFormField(
            style: Theme.of(context).textTheme.headlineSmall,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(15),
              hintText: StringsManager.enterName.tr(),
            ),
            validator: _buildNameValidation,
            onSaved: widget.onSavedName,
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            StringsManager.email.tr(),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: TextFormField(
                  style: Theme.of(context).textTheme.headlineSmall,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15),
                    hintText: StringsManager.enterEmail.tr(),
                    suffixIcon: const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                  ),
                  validator: _buildEmailValidation,
                  onSaved: widget.onSavedEmail,
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: SizedBox(
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: FittedBox(
                      child: Text(
                        StringsManager.verify.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20.h,
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
                    obsecure ? Icons.visibility_off : Icons.remove_red_eye),
              ),
            ),
            obscureText: obsecure,
            validator: _buildPasswordValidation,
            onChanged: (value) {
              password = value;
            },
            onSaved: widget.onSavedPassword,
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            StringsManager.confirmPassword.tr(),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(
            height: 10.h,
          ),
          TextFormField(
            key: _confirmPassword,
            style: Theme.of(context).textTheme.headlineSmall,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(15),
              hintText: StringsManager.enterPassword.tr(),
            ),
            obscureText: obsecure,
            validator: _buildConfirmPasswordValidation,
            onChanged: (value) {
              _confirmPassword.currentState!.validate();
            },
          ),
        ],
      ),
    );
  }

  String? _buildConfirmPasswordValidation(value) {
    if (password != value) {
      return StringsManager.confirmPasswordValidation.tr();
    }
    return null;
  }

  String? _buildPasswordValidation(value) {
    if (value == null || value.isEmpty) {
      return StringsManager.passwordValidation.tr();
    }
    String validationMessage = _validatePassword(value);
    if (validationMessage.isNotEmpty) {
      return validationMessage;
    }
    return null;
  }

  String? _buildNameValidation(value) {
    if (value == null || value.length < 3) {
      return StringsManager.nameValidation.tr();
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

  String _validatePassword(String password) {
    RegExp lowercaseRegex = RegExp(r'[a-z]');
    RegExp uppercaseRegex = RegExp(r'[A-Z]');
    RegExp digitRegex = RegExp(r'\d');
    RegExp specialCharRegex = RegExp(r'[!@#$%^&*()_+{}\[\]:;<>,.?~\\/-]');
    int minLength = 6;
    int maxLength = 4096;

    if (!lowercaseRegex.hasMatch(password)) {
      return StringsManager.lowercaseValidation.tr();
    }

    if (!uppercaseRegex.hasMatch(password)) {
      return StringsManager.uppercaseValidation.tr();
    }

    if (!digitRegex.hasMatch(password)) {
      return StringsManager.numberValidation.tr();
    }

    if (!specialCharRegex.hasMatch(password)) {
      return StringsManager.specialValidation.tr();
    }

    if (password.length < minLength || password.length > maxLength) {
      return StringsManager.lengthValidation.tr();
    }

    return '';
  }
}
