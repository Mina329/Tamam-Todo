import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/utils/color_manager.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/core/widgets/custom_icons/custom_icons_icons.dart';
import 'package:todo/features/home/presentation/view/widgets/add_task_action_buttons.dart';
import 'package:todo/features/home/presentation/view/widgets/add_task_form.dart';

class CustomFloatingActionButton extends StatefulWidget {
  const CustomFloatingActionButton({
    super.key,
  });

  @override
  State<CustomFloatingActionButton> createState() =>
      _CustomFloatingActionButtonState();
}

class _CustomFloatingActionButtonState
    extends State<CustomFloatingActionButton> {
  bool isShowing = false;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        if (isShowing) {
          GoRouter.of(context).pop();
        } else {
          _showCustomBottomSheet(context);
        }
      },
      shape: const CircleBorder(),
      backgroundColor: ColorManager.primaryColor,
      child: const Icon(
        CustomIcons.add_icon,
        color: Colors.white,
      ),
    );
  }

  void _showCustomBottomSheet(BuildContext context) {
    isShowing = true;
    showBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: 225.h,
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.only(left: 25.w, right: 25.w, top: 20.h, bottom: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                StringsManager.addTask,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(
                height: 15.h,
              ),
              const AddTaskForm(),
              const Spacer(),
              const AddTaskActionButtons()
            ],
          ),
        ),
      ),
    ).closed.whenComplete(() {
      isShowing = false;
    });
  }
}
