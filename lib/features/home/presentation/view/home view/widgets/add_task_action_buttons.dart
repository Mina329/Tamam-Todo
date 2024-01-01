import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/utils/color_manager.dart';
import 'package:todo/core/utils/service_locator.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/core/widgets/custom_icons/custom_icons_icons.dart';
import 'package:todo/core/widgets/custom_loading_animation.dart';
import 'package:todo/features/home/domain/entities/category.dart';
import 'package:todo/features/home/domain/usecases/delete_category_use_case.dart';
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
        BlocConsumer<GetCategoriesCubit, GetCategoriesState>(
          listener: (context, state) {
            if (state is GetCategoriesFailure) {
              Fluttertoast.showToast(msg: state.errMessage);
            }
          },
          builder: (context, state) {
            if (state is GetCategoriesSucecess) {
              return IconButton(
                onPressed: () {
                  buildChooseCategoryDialog(context, state.categories,
                      BlocProvider.of<GetCategoriesCubit>(context));
                },
                icon: Icon(
                  CustomIcons.tag_icon,
                  size: 27.sp,
                  color: selectedCategoryIndex != null
                      ? ColorManager.primaryColor
                      : null,
                ),
              );
            }
            return IconButton(
              onPressed: null,
              icon: Icon(
                CustomIcons.tag_icon,
                size: 27.sp,
                color: selectedCategoryIndex != null
                    ? ColorManager.primaryColor
                    : null,
              ),
            );
          },
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

  void buildChooseCategoryDialog(
      BuildContext context,
      List<CategoryEntity> categories,
      GetCategoriesCubit getCategoriesCubit) async {
    await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) => Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              child: BlocProvider(
                create: (context) => DeleteCategoryCubit(
                  getIt.get<DeleteCategoryUseCase>(),
                ),
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
                      _buildChooseCategoryGridView(
                          setState, categories, getCategoriesCubit),
                      SizedBox(height: 16.h),
                      SaveCancelActionButtons(
                        cancelOnPressed: () {
                          selectedCategoryIndex = null;
                          widget.onSelectCategory(null);
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
            ),
          ),
        );
      },
    );
    setState(() {});
  }

  Widget _buildChooseCategoryGridView(StateSetter setState,
      List<CategoryEntity> categories, GetCategoriesCubit getCategoriesCubit) {
    return BlocListener<DeleteCategoryCubit, DeleteCategoryState>(
      listener: (context, state) {
        if (state is DeleteCategoryLoading) {
          CustomLoadingAnimation.buildLoadingIndicator(context);
        } else if (state is DeleteCategoryFailure) {
          GoRouter.of(context).pop();
          Fluttertoast.showToast(
            msg: state.errMessage,
            toastLength: Toast.LENGTH_SHORT,
          );
        } else if (state is DeleteCategorySuccess) {
          GoRouter.of(context).pop();
          categories.removeWhere((element) => element.id == state.id);
          setState(() {});
        }
      },
      child: SizedBox(
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
                  if (index < categories.length) {
                    return TaskCategoryItem(
                      selected: selectedCategoryIndex == index,
                      category: categories[index],
                      onTap: () {
                        selectedCategoryIndex = index;
                        widget.onSelectCategory(categories[index]);
                        setState(() {});
                      },
                      onDelete: () {
                        BlocProvider.of<DeleteCategoryCubit>(context)
                            .deleteCategory(categories[index].id);
                      },
                    );
                  } else {
                    return AddCategoryButton(
                      getCategoriesCubit: getCategoriesCubit,
                    );
                  }
                },
                childCount: categories.length + 1,
              ),
            ),
          ],
        ),
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
        initialTime: TimeOfDay.now(),
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
