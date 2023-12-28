import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/utils/strings_manager.dart';

class SendButton extends StatefulWidget {
  const SendButton({
    Key? key,
    required this.forgetPassword,
  }) : super(key: key);
  final GlobalKey<FormFieldState<String>> forgetPassword;
  @override
  SendButtonState createState() => SendButtonState();
}

class SendButtonState extends State<SendButton> {
  bool isButtonDisabled = false;
  int countdown = 120;
  late Timer countdownTimer;

  @override
  void dispose() {
    countdownTimer.cancel();
    super.dispose();
  }

  void startCountdown() {
    setState(() {
      isButtonDisabled = true;
      countdown = 120;
    });

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        countdown -= 1;
      });

      if (countdown == 0) {
        timer.cancel();
        setState(() {
          isButtonDisabled = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: 48.h,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isButtonDisabled
                ? null
                : () {
                    if (widget.forgetPassword.currentState!.validate()) {
                      widget.forgetPassword.currentState!.save();
                      startCountdown();
                    }
                  },
            child: Text(
              StringsManager.send.tr(),
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Colors.white),
            ),
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        if (isButtonDisabled)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                StringsManager.resendIn.tr(),
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                countdown.toString(),
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                StringsManager.seconds.tr(),
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
        SizedBox(
          height: 40.h,
        ),
      ],
    );
  }
}
