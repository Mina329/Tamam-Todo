import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/core/widgets/custom_icons/custom_icons_icons.dart';
import 'package:todo/features/profile/presentation/view/profile%20view/widgets/custom_list_tile.dart';

class SettingsListTiles extends StatelessWidget {
  const SettingsListTiles({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomListTile(
          icon: CustomIcons.change_theme_icon,
          name: StringsManager.changeAppColor,
          onTap: () {},
        ),
        SizedBox(
          height: 16.h,
        ),
        CustomListTile(
          icon: CustomIcons.language_icon,
          name: StringsManager.changeAppLanguage,
          onTap: () {},
        ),
      ],
    );
  }
}
