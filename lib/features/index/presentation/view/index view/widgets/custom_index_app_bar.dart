import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo/core/utils/service_locator.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/core/widgets/custom_icons/custom_icons_icons.dart';
import 'package:todo/core/widgets/custom_loading_animation.dart';
import 'package:todo/features/home/domain/entities/task.dart';
import 'package:todo/features/index/presentation/manager/get_tasks_by_day_cubit/get_tasks_by_day_cubit.dart';

class CustomIndexAppBar extends StatelessWidget {
  const CustomIndexAppBar({
    Key? key,
    required this.isFilterActive,
    this.uncompleted,
    this.completed,
  }) : super(key: key);
  final bool isFilterActive;
  final List<TaskEntity>? uncompleted;
  final List<TaskEntity>? completed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSortDropDown(context),
        Text(
          StringsManager.index.tr(),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        _buildProfileImage(),
      ],
    );
  }

  Widget _buildSortDropDown(BuildContext context) {
    return isFilterActive
        ? PopupMenuButton(
            icon: const Icon(
              CustomIcons.sort_icon,
            ),
            offset: Offset.fromDirection(1.25, 35.sp),
            itemBuilder: (context) => [
              PopupMenuItem<String>(
                value: 'name',
                child: Text(
                  StringsManager.name.tr(),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              PopupMenuItem<String>(
                value: 'priority',
                child: Text(
                  StringsManager.priority.tr(),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ],
            onSelected: (selected) {
              if (selected == 'name') {
                BlocProvider.of<GetTasksByDayCubit>(context)
                    .filterByNameAndPriority(
                        byName: true,
                        completed: completed!,
                        uncompleted: uncompleted!);
              } else {
                BlocProvider.of<GetTasksByDayCubit>(context)
                    .filterByNameAndPriority(
                        byName: false,
                        completed: completed!,
                        uncompleted: uncompleted!);
              }
            },
          )
        : PopupMenuButton(
            icon: const Icon(
              CustomIcons.sort_icon,
            ),
            offset: Offset.fromDirection(1.25, 35.sp),
            itemBuilder: (context) => [],
            onSelected: null,
          );
  }

  Container _buildProfileImage() {
    return Container(
      width: 40.w,
      height: 40.w,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: getIt.get<FirebaseAuth>().currentUser!.photoURL ?? '',
          placeholder: (context, str) => const CustomCircularIndicator(),
          errorWidget: (context, str, obj) => Icon(
            FontAwesomeIcons.circleExclamation,
            size: 22.sp,
          ),
        ),
      ),
    );
  }
}
