import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/features/onboarding/presentation/view/widgets/onboarding_action_buttons.dart';
import 'package:todo/features/onboarding/presentation/view/widgets/page_index_indicator.dart';
import 'package:todo/features/onboarding/presentation/view/widgets/page_view_body.dart';
import 'package:todo/features/onboarding/presentation/view/widgets/skip_button.dart';

class OnboardingViewBody extends StatefulWidget {
  const OnboardingViewBody({super.key});

  @override
  State<OnboardingViewBody> createState() => _OnboardingViewBodyState();
}

class _OnboardingViewBodyState extends State<OnboardingViewBody> {
  late final PageController controller;
  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          SizedBox(
            height: 58.h,
          ),
          SkipBackButton(
            text: StringsManager.skip,
            onPressed: () {},
          ),
          PageViewBody(
            controller: controller,
          ),
          PageIndexIndicator(controller: controller),
          SizedBox(
            height: 50.h,
          ),
          OnBoardingActionButtons(controller: controller),
          SizedBox(
            height: 62.h,
          ),
        ],
      ),
    );
  }
}
