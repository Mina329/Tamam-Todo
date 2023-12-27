import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/utils/strings_manager.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool obsecure = true;
  @override
  Widget build(BuildContext context) {
    return Form(
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
          SizedBox(
            height: 48.h,
            child: TextFormField(
              style: Theme.of(context).textTheme.headlineSmall,
              textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
                hintText: StringsManager.enterEmail.tr(),
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
        ],
      ),
    );
  }
}
