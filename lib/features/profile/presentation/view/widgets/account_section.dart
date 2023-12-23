import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/core/widgets/custom_icons/custom_icons_icons.dart';
import 'package:todo/features/profile/presentation/view/widgets/custom_list_tile.dart';
import 'package:todo/features/profile/presentation/view/widgets/custom_profile_section_title.dart';

class AccountSection extends StatelessWidget {
  AccountSection({super.key});
  final List<IconData> icons = [
    CustomIcons.inactive_profile_icon,
    CustomIcons.password_icon,
    CustomIcons.camera_icon,
  ];
  final List<String> names = [
    StringsManager.changeAccountName,
    StringsManager.changeAccountPassword,
    StringsManager.changeAccountImage
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomProfileSectionTitle(
          title: StringsManager.account,
        ),
        SizedBox(
          height: 5.h,
        ),
        Column(
          children: List.generate(
            3,
            (index) => Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: CustomListTile(
                icon: icons[index],
                name: names[index],
                onTap: () {},
              ),
            ),
          ),
        ),
      ],
    );
  }
}
