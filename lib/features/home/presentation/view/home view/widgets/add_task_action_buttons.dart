import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/utils/assets_manager.dart';
import 'package:todo/core/utils/color_manager.dart';
import 'package:todo/core/utils/service_locator.dart';
import 'package:todo/core/utils/strings_manager.dart';
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
import 'package:todo/features/home/presentation/view/home%20view/widgets/task_priority_item.dart';

class AddTaskActionButtons extends StatefulWidget {
  const AddTaskActionButtons({
    super.key,
    required this.onSend,
    required this.onSelectDateTime,
    required this.onSelectCategory,
    required this.onSelectPriority,
  });
  final Function() onSend;
  final Function(DateTime?) onSelectDateTime;
  final Function(CategoryEntity?) onSelectCategory;
  final Function(int?) onSelectPriority;

  @override
  State<AddTaskActionButtons> createState() => _AddTaskActionButtonsState();
}

class _AddTaskActionButtonsState extends State<AddTaskActionButtons> {
  DateTime? selectedDate;
  TimeOfDay? selectedTimeOfDay;
  int? selectedTaskPriority;
  int? selectedCategoryIndex;
  CategoryEntity? categoryEntity;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () async {
            await _showCalendarAndTime(context);
          },
          icon: Icon(
            CustomIcons.clock_icon,
            size: 27.sp,
            color: selectedTimeOfDay != null ? ColorManager.primaryColor : null,
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        IconButton(
          onPressed: () {
            buildChooseCategoryDialog(context);
          },
          icon: Icon(
            CustomIcons.tag_icon,
            size: 27.sp,
            color: selectedCategoryIndex != null
                ? ColorManager.primaryColor
                : null,
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        IconButton(
          onPressed: () {
            _buildTaskPriorityDialog(context);
          },
          icon: Icon(
            CustomIcons.flag_icon,
            size: 27.sp,
            color:
                selectedTaskPriority != null ? ColorManager.primaryColor : null,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: widget.onSend,
          icon: Icon(
            CustomIcons.send_icon,
            size: 27.sp,
            color: ColorManager.primaryColor,
          ),
        ),
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
                child: IntrinsicHeight(
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
                          categoryEntity = null;
                          widget.onSelectCategory(null);
                          GoRouter.of(context).pop();
                        },
                        saveOnPressed: () {
                          widget.onSelectCategory(categoryEntity);
                          GoRouter.of(context).pop();
                        },
                      ),
                    ],
                  ),
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
                              categoryEntity = state.categories[index];
                              setState(() {
                                selectedCategoryIndex = index;
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

  void _buildTaskPriorityDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) => Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    StringsManager.taskPriority.tr(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  const Divider(),
                  SizedBox(
                    height: 5.h,
                  ),
                  _buildTaskPriorityGridView(setState),
                  SizedBox(height: 16.h),
                  SaveCancelActionButtons(
                    cancelOnPressed: () {
                      selectedTaskPriority = null;
                      widget.onSelectPriority(null);
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

  GridView _buildTaskPriorityGridView(StateSetter setState) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return TaskPriorityItem(
          onTap: () {
            selectedTaskPriority = index + 1;
            widget.onSelectPriority(index + 1);
            setState(() {});
          },
          index: (index + 1).toString(),
          selected: selectedTaskPriority == index + 1,
        );
      },
    );
  }

  Future<void> _showCalendarAndTime(BuildContext context) async {
    selectedDate = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2223),
        confirmText: StringsManager.chooseTime.tr(),
        initialDate: DateTime.now());
    if (selectedDate != null && context.mounted) {
      selectedTimeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(
          hour: TimeOfDay.now().hour,
          minute: TimeOfDay.now().minute + 1,
        ),
      );
      if (selectedTimeOfDay != null) {
        DateTime selectedDateTime = DateTime(
          selectedDate!.year,
          selectedDate!.month,
          selectedDate!.day,
          selectedTimeOfDay!.hour,
          selectedTimeOfDay!.minute,
        );
        if (selectedDateTime.isAfter(DateTime.now())) {
          widget.onSelectDateTime(
            DateTime(selectedDate!.year, selectedDate!.month, selectedDate!.day,
                selectedTimeOfDay!.hour, selectedTimeOfDay!.minute),
          );
        } else {
          selectedDate = null;
          widget.onSelectDateTime(null);
          selectedTimeOfDay = null;
        }
        setState(() {});
      } else {
        selectedDate = null;
        widget.onSelectDateTime(null);
        selectedTimeOfDay = null;
        setState(() {});
      }
    } else {
      selectedDate = null;
      selectedTimeOfDay = null;
      widget.onSelectDateTime(null);
      setState(() {});
    }
  }
}
