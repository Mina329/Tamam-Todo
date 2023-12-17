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
            StringsManager.username,
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
              decoration: const InputDecoration(
                hintText: StringsManager.enterUsername,
              ),
            ),
          ),
          SizedBox(
            height: 25.h,
          ),
          Text(
            StringsManager.password,
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
                hintText: StringsManager.enterPassword,
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
