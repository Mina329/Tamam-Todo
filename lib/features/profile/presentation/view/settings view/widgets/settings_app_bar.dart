import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/utils/strings_manager.dart';

class SettingsAppBar extends StatelessWidget {
  const SettingsAppBar({
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
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        const Spacer(),
        Text(
          StringsManager.settings,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const Spacer(),
      ],
    );
  }
}
