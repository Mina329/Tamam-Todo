import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/utils/app_router.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/features/onboarding/presentation/view/widgets/skip_button.dart';

class OnBoardingActionButtons extends StatefulWidget {
  const OnBoardingActionButtons({
    super.key,
    required this.controller,
  });

  final PageController controller;

  @override
  State<OnBoardingActionButtons> createState() =>
      _OnBoardingActionButtonsState();
}

class _OnBoardingActionButtonsState extends State<OnBoardingActionButtons> {
  String text = StringsManager.next.tr();
  @override
  Widget build(BuildContext context) {
    widget.controller.addListener(() {
      if (widget.controller.page! >= 1.5) {
        setState(() {
          text = StringsManager.getStarted.tr();
        });
      } else {
        setState(() {
          text = StringsManager.next.tr();
        });
      }
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SkipBackButton(
          text: StringsManager.back.tr(),
          onPressed: () {
            widget.controller.previousPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          },
        ),
        ElevatedButton(
          onPressed: () {
            if (widget.controller.page! >= 1.5) {
              GoRouter.of(context).go(AppRouter.kAuthView);
            } else {
              widget.controller.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease,
              );
            }
          },
          child: SizedBox(
            height: 50.h,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: Center(
                child: Text(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
