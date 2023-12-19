import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/utils/color_manager.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/core/widgets/custom_loading_animation.dart';

class CreateCategoryActionButtons extends StatelessWidget {
  const CreateCategoryActionButtons({
    super.key,
  });

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
                    StringsManager.cancel,
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
                onPressed: () {
                  CustomLoadingAnimation.buildLoadingIndicator(context);
                },
                child: Text(
                  StringsManager.save,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.white,
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
