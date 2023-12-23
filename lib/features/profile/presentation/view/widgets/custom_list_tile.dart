import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    required this.icon,
    required this.name,
    this.onTap,
  }) : super(key: key);
  final IconData icon;
  final String name;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(5),
      child: SizedBox(
        height: 48.h,
        child: Row(
          children: [
            Icon(
              icon,
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios_outlined,
            )
          ],
        ),
      ),
    );
  }
}
