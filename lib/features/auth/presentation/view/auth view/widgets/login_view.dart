import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/features/auth/presentation/view/auth%20view/widgets/login_form.dart';

class LoginView extends StatelessWidget {
  const LoginView({
    super.key,
  });

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
        const LoginForm(),
        SizedBox(
          height: 70.h,
        ),
        ElevatedButton(
          onPressed: () {},
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
        SizedBox(
          height: 30.h,
        ),
      ],
    );
  }
}
