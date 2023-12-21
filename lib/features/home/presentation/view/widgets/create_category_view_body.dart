import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/core/widgets/custom_sliver_sizedbox.dart';
import 'package:todo/features/home/presentation/view/widgets/category_color_section.dart';
import 'package:todo/features/home/presentation/view/widgets/category_icon_section.dart';
import 'package:todo/features/home/presentation/view/widgets/category_name_section.dart';
import 'package:todo/features/home/presentation/view/widgets/create_category_action_buttons.dart';
import 'package:todo/features/home/presentation/view/widgets/create_category_back_arrow.dart';

class CreateCategoryViewBody extends StatelessWidget {
  const CreateCategoryViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverSizedBox(
            height: 50.h,
          ),
          const SliverToBoxAdapter(
            child: CreateCategoryBackArrow(),
          ),
          SliverSizedBox(
            height: 20.h,
          ),
          SliverToBoxAdapter(
            child: Text(
              StringsManager.createNew,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          SliverSizedBox(
            height: 20.h,
          ),
          const SliverToBoxAdapter(
            child: CategoryNameSection(),
          ),
          const SliverToBoxAdapter(
            child: CategoryIconSection(),
          ),
          const SliverToBoxAdapter(
            child: CategoryColorSection(),
          ),
          const SliverFillRemaining(
            hasScrollBody: false,
            child: CreateCategoryActionButtons(),
          ),
        ],
      ),
    );
  }
}
