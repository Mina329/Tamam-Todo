import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/utils/app_router.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/core/widgets/custom_icons/custom_icons_icons.dart';
import 'package:todo/features/profile/presentation/view/profile%20view/widgets/custom_list_tile.dart';
import 'package:todo/features/profile/presentation/view/profile%20view/widgets/custom_profile_section_title.dart';

class SettingSection extends StatelessWidget {
  const SettingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomProfileSectionTitle(
          title: StringsManager.settings.tr(),
        ),
        SizedBox(
          height: 5.h,
        ),
        CustomListTile(
          icon: CustomIcons.setting_icon,
          name: StringsManager.appSettings.tr(),
          onTap: () {
            GoRouter.of(context).push(
              AppRouter.kSettingsView,
            );
          },
        ),
      ],
    );
  }
}
