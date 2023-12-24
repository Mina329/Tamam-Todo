import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/core/widgets/custom_simple_appbar.dart';
import 'package:todo/core/widgets/custom_sliver_sizedbox.dart';
import 'package:todo/features/profile/presentation/view/profile%20view/widgets/account_section.dart';
import 'package:todo/features/profile/presentation/view/profile%20view/widgets/app_about_section.dart';
import 'package:todo/features/profile/presentation/view/profile%20view/widgets/log_out_button.dart';
import 'package:todo/features/profile/presentation/view/profile%20view/widgets/profile_card.dart';
import 'package:todo/features/profile/presentation/view/profile%20view/widgets/settings_section.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverSizedBox(
            height: 56.h,
          ),
          SliverToBoxAdapter(
            child: CustomSimpleAppBar(
              title: StringsManager.profile.tr(),
            ),
          ),
          SliverSizedBox(
            height: 24.h,
          ),
          const SliverToBoxAdapter(
            child: ProfileCard(
              imgUrl: 'https://avatars.githubusercontent.com/u/96777964?v=4',
              name: 'Mina Emil',
              tasksDone: '7 Tasks Done',
              tasksMissed: '10 Tasks Missed',
            ),
          ),
          SliverSizedBox(
            height: 32.h,
          ),
          const SliverToBoxAdapter(
            child: SettingSection(),
          ),
          SliverSizedBox(
            height: 16.h,
          ),
          const SliverToBoxAdapter(
            child: AccountSection(),
          ),
          SliverSizedBox(
            height: 8.h,
          ),
          SliverToBoxAdapter(
            child: AppAboutSection(),
          ),
          SliverToBoxAdapter(
            child: LogOutButton(
              onTap: () {},
            ),
          ),
          SliverSizedBox(
            height: 30.h,
          ),
        ],
      ),
    );
  }
}
