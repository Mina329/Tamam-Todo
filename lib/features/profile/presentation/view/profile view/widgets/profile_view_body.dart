import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/cache/cache_helper.dart';
import 'package:todo/core/cache/cache_keys_values.dart';
import 'package:todo/core/database/database.dart';
import 'package:todo/core/utils/service_locator.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/core/widgets/custom_simple_appbar.dart';
import 'package:todo/core/widgets/custom_sliver_sizedbox.dart';
import 'package:todo/features/profile/presentation/view/profile%20view/widgets/account_section.dart';
import 'package:todo/features/profile/presentation/view/profile%20view/widgets/app_about_section.dart';
import 'package:todo/features/profile/presentation/view/profile%20view/widgets/log_out_button.dart';
import 'package:todo/features/profile/presentation/view/profile%20view/widgets/profile_card.dart';
import 'package:todo/features/profile/presentation/view/profile%20view/widgets/settings_section.dart';

import '../../../../../../core/utils/app_router.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
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
          const SliverToBoxAdapter(
            child: AppAboutSection(),
          ),
          SliverToBoxAdapter(
            child: LogOutButton(
              onTap: () async {
                clearDataBase();
                await CacheData.setData(key: CacheKeys.kDATE, value: null);
                await CacheData.setData(key: CacheKeys.kSECONDS, value: null);
                getIt.get<FirebaseAuth>().signOut();
                if (context.mounted) {
                  GoRouter.of(context).go(AppRouter.kAuthView);
                }
              },
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
