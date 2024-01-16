import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/utils/color_manager.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/core/widgets/custom_loading_animation.dart';

class CreateCategoryActionButtons extends StatelessWidget {
  const CreateCategoryActionButtons({
    super.key,
    this.onPressed,
  });
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () async {
                FocusScope.of(context).unfocus();
                CustomLoadingAnimation.buildLoadingIndicator(context);
                await Future.delayed(
                  const Duration(milliseconds: 1000),
                );
                if (context.mounted) {
                  GoRouter.of(context).pop();
                  GoRouter.of(context).pop();
                }
              },
              borderRadius: BorderRadius.circular(5),
              child: SizedBox(
                height: 50.h,
                width: 150.w,
                child: Center(
                  child: Text(
                    StringsManager.cancel.tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: ColorManager.primaryColor,
                        ),
                  ),
                ),
              ),
            ),
            const SizedBox(),
            SizedBox(
              height: 50.h,
              width: 150.w,
              child: ElevatedButton(
                onPressed: onPressed,
                child: FittedBox(
            fit: BoxFit.scaleDown,
                  child: Text(
                    StringsManager.save.tr(),
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 70.h,
        ),
      ],
    );
  }
}
