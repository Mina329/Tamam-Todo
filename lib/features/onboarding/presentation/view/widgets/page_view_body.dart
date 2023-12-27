import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/core/utils/assets_manager.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/core/widgets/custom_sliver_sizedbox.dart';

class PageViewBody extends StatelessWidget {
  PageViewBody({
    super.key,
    required this.controller,
  });

  final PageController controller;
  final List<String> images = [
    AssetsManager.onboarding1,
    AssetsManager.onboarding2,
    AssetsManager.onboarding3
  ];

  final List<String> titles = [
    StringsManager.onboarding1.tr(),
    StringsManager.onboarding2.tr(),
    StringsManager.onboarding3.tr()
  ];

  final List<String> subTitles = [
    StringsManager.onboarding1Description.tr(),
    StringsManager.onboarding2Description.tr(),
    StringsManager.onboarding3Description.tr()
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        physics: const ClampingScrollPhysics(),
        itemCount: 3,
        controller: controller,
        itemBuilder: (context, index) {
          return CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              SliverSizedBox(
                height: 10.h,
              ),
              SliverToBoxAdapter(
                child: SvgPicture.asset(
                  images[index],
                  width: 213.w,
                  height: 277.h,
                ),
              ),
              SliverSizedBox(
                height: 80.h,
              ),
              SliverToBoxAdapter(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    titles[index],
                    style: Theme.of(context).textTheme.displayMedium,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                ),
              ),
              SliverSizedBox(
                height: 40.h,
              ),
              SliverToBoxAdapter(
                child: FittedBox(
                  child: Text(
                    subTitles[index],
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                    maxLines: 3,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
