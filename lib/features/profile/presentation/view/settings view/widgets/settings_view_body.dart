import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/widgets/custom_sliver_sizedbox.dart';
import 'package:todo/features/profile/presentation/view/settings%20view/widgets/settings_app_bar.dart';
import 'package:todo/features/profile/presentation/view/settings%20view/widgets/settings_list_tiles.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

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
          const SliverToBoxAdapter(
            child: SettingsAppBar(),
          ),
          SliverSizedBox(
            height: 20.h,
          ),
          const SliverToBoxAdapter(
            child: SettingsListTiles(),
          ),
        ],
      ),
    );
  }
}
