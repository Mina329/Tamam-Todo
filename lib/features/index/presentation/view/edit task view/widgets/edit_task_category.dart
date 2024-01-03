import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/utils/assets_manager.dart';
import 'package:todo/core/utils/functions/extensions.dart';
import 'package:todo/core/utils/service_locator.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/core/widgets/custom_clickable_container.dart';
import 'package:todo/core/widgets/custom_icons/custom_icons_icons.dart';
import 'package:todo/core/widgets/custom_loading_animation.dart';
import 'package:todo/features/home/domain/entities/category.dart';
import 'package:todo/features/home/domain/usecases/delete_category_use_case.dart';
import 'package:todo/features/home/domain/usecases/get_all_categories_use_case.dart';
import 'package:todo/features/home/presentation/manager/delete_category_cubit/delete_category_cubit.dart';
import 'package:todo/features/home/presentation/manager/get_categories_cubit/get_categories_cubit.dart';
import 'package:todo/features/home/presentation/view/home%20view/widgets/add_category_button.dart';
import 'package:todo/features/home/presentation/view/home%20view/widgets/task_category_item.dart';
import 'package:todo/core/widgets/save_cancel_action_buttons.dart';

class EditTaskCategory extends StatefulWidget {
  const EditTaskCategory(
      {super.key, required this.categoryEntity, required this.onSavedCategory});
  final CategoryEntity categoryEntity;
  final Function(CategoryEntity) onSavedCategory;
  @override
  State<EditTaskCategory> createState() => _EditTaskCategoryState();
}

class _EditTaskCategoryState extends State<EditTaskCategory> {
  late String id;
  late String categoryName;
  late int iconData;
  late String color;
  int? selectedCategoryIndex;

  @override
  void initState() {
    super.initState();
    id = widget.categoryEntity.id;
    categoryName = widget.categoryEntity.name;
    iconData = widget.categoryEntity.iconData;
    color = widget.categoryEntity.color;
  }

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
          text: categoryName,
          icon: Icon(
            iconData.toIconData(),
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
        return BlocProvider(
          create: (context) => GetCategoriesCubit(
            getIt.get<GetAllCategoriesUseCase>(),
          )..getAllCategories(),
          child: Dialog(
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) =>
                  Container(
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
                        id = widget.categoryEntity.id;
                        color = widget.categoryEntity.color;
                        iconData = widget.categoryEntity.iconData;
                        categoryName = widget.categoryEntity.name;
                        widget.onSavedCategory(
                          CategoryEntity(
                            id: id,
                            name: categoryName,
                            iconData: iconData,
                            color: color,
                          ),
                        );
                        GoRouter.of(context).pop();
                      },
                      saveOnPressed: () {
                        widget.onSavedCategory(
                          CategoryEntity(
                            id: id,
                            name: categoryName,
                            iconData: iconData,
                            color: color,
                          ),
                        );
                        GoRouter.of(context).pop();
                      },
                    ),
                  ],
                ),
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
      height: MediaQuery.of(context).size.height * 0.3,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          BlocBuilder<GetCategoriesCubit, GetCategoriesState>(
            builder: (context, state) {
              if (state is GetCategoriesLoading) {
                return const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: CustomCircularIndicator(),
                  ),
                );
              } else if (state is GetCategoriesFailure) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: SvgPicture.asset(
                          AssetsManager.error,
                          width: 150.w,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        StringsManager.operationNotAllowed.tr(),
                        style: Theme.of(context).textTheme.headlineSmall,
                      )
                    ],
                  ),
                );
              } else if (state is GetCategoriesSuccess) {
                return SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 20.w,
                    mainAxisSpacing: 20.h,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      if (index < state.categories.length) {
                        return BlocProvider(
                          create: (context) => DeleteCategoryCubit(
                            getIt.get<DeleteCategoryUseCase>(),
                          ),
                          child: TaskCategoryItem(
                            category: state.categories[index],
                            selected: selectedCategoryIndex == index,
                            onTap: () {
                              setState(() {
                                selectedCategoryIndex = index;
                                id = state.categories[index].id;
                                color = state.categories[index].color;
                                iconData = state.categories[index].iconData;
                                categoryName = state.categories[index].name;
                              });
                            },
                          ),
                        );
                      } else {
                        return AddCategoryButton(
                          getCategoriesCubit:
                              BlocProvider.of<GetCategoriesCubit>(context),
                        );
                      }
                    },
                    childCount: state.categories.length + 1,
                  ),
                );
              }
              return const SliverToBoxAdapter();
            },
          ),
        ],
      ),
    );
  }
}
