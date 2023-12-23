import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/core/widgets/custom_icons/custom_icons_icons.dart';
import 'package:todo/features/profile/presentation/view/widgets/custom_list_tile.dart';
import 'package:todo/features/profile/presentation/view/widgets/custom_profile_section_title.dart';

class SettingSection extends StatelessWidget {
  const SettingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomProfileSectionTitle(
          title: StringsManager.settings,
        ),
        SizedBox(
          height: 5.h,
        ),
        CustomListTile(
          icon: CustomIcons.setting_icon,
          name: StringsManager.appSettings,
          onTap: () {},
        ),
      ],
    );
  }
}
