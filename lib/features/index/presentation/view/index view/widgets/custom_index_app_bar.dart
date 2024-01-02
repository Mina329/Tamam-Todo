// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/core/widgets/custom_icons/custom_icons_icons.dart';
import 'package:todo/core/widgets/custom_loading_animation.dart';

class CustomIndexAppBar extends StatelessWidget {
  const CustomIndexAppBar({
    Key? key,
    required this.isFilterActive,
  }) : super(key: key);
  final bool isFilterActive;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSortDropDown(),
        Text(
          StringsManager.index.tr(),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        _buildProfileImage(),
      ],
    );
  }

  Widget _buildSortDropDown() {
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
              log(selected);
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
          imageUrl: 'https://avatars.githubusercontent.com/u/96777964?v=4',
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
