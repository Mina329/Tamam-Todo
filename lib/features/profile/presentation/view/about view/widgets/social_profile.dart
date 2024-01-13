import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SocialProfile extends StatelessWidget {
  const SocialProfile({
    super.key,
    required this.image,
    required this.text,
    required this.onTap,
  });
  final String image;
  final String text;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            image,
          ),
          SizedBox(
            width: 10.w,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.titleSmall,
          )
        ],
      ),
    );
  }
}
