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
          SizedBox(
            height: 25.h,
          ),
          Text(
            StringsManager.confirmPassword,
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
                hintText: StringsManager.enterPassword,
              ),
              obscureText: obsecure,
            ),
          ),
        ],
      ),
    );
  }
}
