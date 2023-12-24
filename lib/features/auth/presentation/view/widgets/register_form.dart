import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/utils/strings_manager.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool obsecure = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringsManager.username.tr(),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(
            height: 10.h,
          ),
          SizedBox(
            height: 48.h,
            child: TextFormField(
              style: Theme.of(context).textTheme.headlineSmall,
              textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
                hintText: StringsManager.enterUsername.tr(),
              ),
            ),
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
          SizedBox(
            height: 48.h,
            child: TextFormField(
              style: Theme.of(context).textTheme.headlineSmall,
              textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
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
            ),
          ),
          SizedBox(
            height: 25.h,
          ),
          Text(
            StringsManager.confirmPassword.tr(),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(
            height: 10.h,
          ),
          SizedBox(
            height: 48.h,
            child: TextFormField(
              style: Theme.of(context).textTheme.headlineSmall,
              textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
                hintText: StringsManager.enterPassword.tr(),
              ),
              obscureText: obsecure,
            ),
          ),
        ],
      ),
    );
  }
}
