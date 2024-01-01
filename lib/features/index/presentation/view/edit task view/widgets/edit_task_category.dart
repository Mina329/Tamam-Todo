import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/core/widgets/custom_clickable_container.dart';
import 'package:todo/core/widgets/custom_icons/custom_icons_icons.dart';
import 'package:todo/features/home/domain/entities/category.dart';
import 'package:todo/features/home/presentation/manager/get_categories_cubit/get_categories_cubit.dart';
import 'package:todo/features/home/presentation/view/home%20view/widgets/add_category_button.dart';
import 'package:todo/features/home/presentation/view/home%20view/widgets/task_category_item.dart';
import 'package:todo/core/widgets/save_cancel_action_buttons.dart';

class EditTaskCategory extends StatefulWidget {
  const EditTaskCategory({super.key});

  @override
  State<EditTaskCategory> createState() => _EditTaskCategoryState();
}

class _EditTaskCategoryState extends State<EditTaskCategory> {
  int? selectedCategoryIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          CustomIcons.tag_icon,
        ),
        SizedBox(
          width: 8.w,
        ),
        Text(
          StringsManager.taskCategory.tr(),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const Spacer(),
        CustomClickableContainer(
          text: 'University',
          icon: Icon(
            CustomIcons.music_icon,
            color: Colors.white,
            size: 15.sp,
          ),
          onTap: () {
            buildChooseCategoryDialog(context);
          },
        )
      ],
    );
  }

  void buildChooseCategoryDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) => Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    StringsManager.chooseCategory.tr(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  const Divider(),
                  SizedBox(
                    height: 5.h,
                  ),
                  _buildChooseCategoryGridView(setState),
                  SizedBox(height: 16.h),
                  SaveCancelActionButtons(
                    cancelOnPressed: () {
                      selectedCategoryIndex = null;
                      GoRouter.of(context).pop();
                    },
                    saveOnPressed: () {
                      GoRouter.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    setState(() {});
  }

  Widget _buildChooseCategoryGridView(StateSetter setState) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 20.w,
              mainAxisSpacing: 20.h,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (index < 29) {
                  return TaskCategoryItem(
                    category: CategoryEntity(
                        id: 'id',
                        name: 'Grocery',
                        iconData: 58389,
                        color: '#ffff0032'),
                    selected: selectedCategoryIndex == index,
                    onTap: () {
                      selectedCategoryIndex = index;
                      setState(() {});
                    },
                  );
                } else {
                  return AddCategoryButton(
                    getCategoriesCubit:
                        BlocProvider.of<GetCategoriesCubit>(context),
                  );
                }
              },
              childCount: 30,
            ),
          ),
        ],
      ),
    );
  }
}
