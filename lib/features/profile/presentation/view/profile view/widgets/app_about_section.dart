
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/core/widgets/custom_icons/custom_icons_icons.dart';
import 'package:todo/features/profile/presentation/view/profile%20view/widgets/custom_list_tile.dart';
import 'package:todo/features/profile/presentation/view/profile%20view/widgets/custom_profile_section_title.dart';

class AppAboutSection extends StatefulWidget {
  const AppAboutSection({super.key});

  @override
  State<AppAboutSection> createState() => _AppAboutSectionState();
}

class _AppAboutSectionState extends State<AppAboutSection> {
  @override
  void initState() {
    super.initState();
    icons = [
      CustomIcons.about_icon,
      CustomIcons.info_icon,
      CustomIcons.help_feedback_icon,
      CustomIcons.support_icon,
    ];
    names = [
      StringsManager.aboutUs.tr(),
      StringsManager.faq.tr(),
      StringsManager.helpAndFeedback.tr(),
      StringsManager.supportUs.tr(),
    ];
    onTap = [
      () {},
      () {},
      () {},
      () {},
    ];
  }

  late final List<IconData> icons;
  late final List<String> names;
  late final List<Function()?> onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomProfileSectionTitle(
          title: StringsManager.appName.tr(),
        ),
        SizedBox(
          height: 5.h,
        ),
        Column(
          children: List.generate(
            4,
            (index) => Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: CustomListTile(
                icon: icons[index],
                name: names[index],
                onTap: onTap[index],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
