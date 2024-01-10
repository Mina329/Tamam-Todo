import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/utils/service_locator.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/core/widgets/custom_icons/custom_icons_icons.dart';
import 'package:todo/core/widgets/custom_loading_animation.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard(
      {super.key,
      required this.name,
      required this.tasksDone,
      required this.tasksMissed});
  final String name;
  final String tasksDone;
  final String tasksMissed;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 120.w,
          height: 120.w,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: getIt.get<FirebaseAuth>().currentUser?.photoURL ?? '',
              placeholder: (context, str) => const CustomCircularIndicator(),
              errorWidget: (context, str, obj) => Icon(
                CustomIcons.inactive_profile_icon,
                size: 50.sp,
              ),
              fit: BoxFit.fill,
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          getIt.get<FirebaseAuth>().currentUser!.displayName == null ||
                  getIt.get<FirebaseAuth>().currentUser!.displayName!.isEmpty
              ? StringsManager.unknownUser.tr()
              : getIt.get<FirebaseAuth>().currentUser!.displayName!,
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }
}
