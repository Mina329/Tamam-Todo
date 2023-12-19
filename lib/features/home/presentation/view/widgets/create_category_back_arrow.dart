import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/widgets/custom_icons/custom_icons_icons.dart';
import 'package:todo/core/widgets/custom_loading_animation.dart';

class CreateCategoryBackArrow extends StatelessWidget {
  const CreateCategoryBackArrow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () async {
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
          alignment: Alignment.centerLeft,
          icon: const Icon(
            CustomIcons.back_icon,
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
