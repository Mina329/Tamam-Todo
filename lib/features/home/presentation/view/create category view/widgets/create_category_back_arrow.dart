import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/widgets/custom_icons/custom_icons_icons.dart';

class CreateCategoryBackArrow extends StatelessWidget {
  const CreateCategoryBackArrow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            GoRouter.of(context).pop();
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
