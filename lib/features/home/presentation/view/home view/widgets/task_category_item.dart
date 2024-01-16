import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/utils/color_manager.dart';
import 'package:todo/core/utils/functions/blend_colors.dart';
import 'package:todo/core/utils/functions/extensions.dart';
import 'package:todo/core/widgets/custom_loading_animation.dart';
import 'package:todo/features/home/domain/entities/category.dart';
import 'package:todo/features/home/presentation/manager/delete_category_cubit/delete_category_cubit.dart';
import 'package:todo/features/home/presentation/manager/get_categories_cubit/get_categories_cubit.dart';
import 'package:vibration/vibration.dart';

class TaskCategoryItem extends StatefulWidget {
  const TaskCategoryItem({
    super.key,
    required this.selected,
    required this.onTap,
    required this.category,
  });

  final bool selected;
  final Function()? onTap;
  final CategoryEntity category;
  @override
  State<TaskCategoryItem> createState() => _TaskCategoryItemState();
}

class _TaskCategoryItemState extends State<TaskCategoryItem> {
  bool isVisableDelete = false;

  @override
  Widget build(BuildContext context) {
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
          BlocProvider.of<GetCategoriesCubit>(context).getAllCategories();
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              InkWell(
                onTap: widget.onTap,
                onLongPress: () async {
                  Vibration.vibrate(duration: 100);

                  setState(() {
                    isVisableDelete = !isVisableDelete;
                  });
                },
                borderRadius: BorderRadius.circular(4),
                child: Container(
                  width: 50.w,
                  height: 50.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: widget.selected
                          ? ColorManager.primaryColor
                          : Colors.transparent,
                      width: 2.w,
                    ),
                    color: widget.category.color.toColor(),
                  ),
                  child: Icon(
                    widget.category.iconData.toIconData(),
                    color: blendColors(
                        widget.category.color.toColor(), Colors.black),
                  ),
                ),
              ),
              Visibility(
                visible: isVisableDelete,
                child: Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      BlocProvider.of<DeleteCategoryCubit>(context)
                          .deleteCategory(widget.category.id);
                    },
                    child: Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 18.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                widget.category.name,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ),
          const Spacer()
        ],
      ),
    );
  }
}
