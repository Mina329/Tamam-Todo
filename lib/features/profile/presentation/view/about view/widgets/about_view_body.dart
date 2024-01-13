import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/utils/assets_manager.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/core/widgets/custom_icons/custom_icons_icons.dart';
import 'package:todo/core/widgets/custom_loading_animation.dart';
import 'package:todo/features/profile/presentation/view/about%20view/widgets/social_profile.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutViewBody extends StatelessWidget {
  const AboutViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 60.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    GoRouter.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                  ),
                ),
                Text(
                  StringsManager.aboutUs.tr(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
              ],
            ),
          ),
          SizedBox(
            height: 60.h,
          ),
          ClipOval(
            child: CachedNetworkImage(
              imageUrl: 'https://avatars.githubusercontent.com/u/96777964?v=4',
              placeholder: (context, str) => const CustomCircularIndicator(),
              errorWidget: (context, str, obj) => Icon(
                CustomIcons.inactive_profile_icon,
                size: 50.sp,
              ),
              fit: BoxFit.fill,
              width: 150.w,
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Text(
            'Mina Emil',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            "Hi, I'm Mina, a Flutter developer passionate about \ncreating useful and beautiful applications.",
            style: Theme.of(context).textTheme.titleSmall,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            'Connect with me',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          SocialProfile(
            onTap: () async {
              await launchUrl(
                Uri(
                  scheme: 'mailto',
                  path: 'mina.emil.fakhry@outlook.com',
                ),
              );
            },
            image: AssetsManager.outlook,
            text: 'mina.emil.fakhry@outlook.com',
          ),
          SocialProfile(
            onTap: () async {
              await launchUrl(
                  Uri.parse("https://www.linkedin.com/in/mina-emil-fakhry/"));
            },
            image: AssetsManager.linkedin,
            text: 'Mina Emil',
          ),
          SocialProfile(
            onTap: () async {
              await launchUrl(Uri.parse("https://github.com/Mina329"));
            },
            image: AssetsManager.github,
            text: 'Mina329',
          ),
        ],
      ),
    );
  }
}
