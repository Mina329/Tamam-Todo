import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo/core/widgets/custom_loading_animation.dart';
import 'package:todo/features/profile/presentation/view/profile%20view/widgets/task_progress_card.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard(
      {super.key,
      required this.imgUrl,
      required this.name,
      required this.tasksDone,
      required this.tasksMissed});
  final String imgUrl;
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
              imageUrl: imgUrl,
              placeholder: (context, str) => const CustomCircularIndicator(),
              errorWidget: (context, str, obj) => Icon(
                FontAwesomeIcons.circleExclamation,
                size: 22.sp,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          name,
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 20.h,
        ),
        Row(
          children: [
            TaskProgressCard(text: tasksDone),
            SizedBox(
              width: 20.w,
            ),
            TaskProgressCard(text: tasksMissed),
          ],
        )
      ],
    );
  }
}
