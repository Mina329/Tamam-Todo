import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/utils/strings_manager.dart';

class CategoryIconSection extends StatefulWidget {
  const CategoryIconSection({
    super.key,
  });

  @override
  State<CategoryIconSection> createState() => _CategoryIconSectionState();
}

class _CategoryIconSectionState extends State<CategoryIconSection> {
  IconData? icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringsManager.categoryIcon.tr(),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        SizedBox(
          height: 15.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            icon == null
                ? const SizedBox()
                : Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.21),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Icon(icon),
                  ),
            ElevatedButton(
              onPressed: () async {
                icon = await FlutterIconPicker.showIconPicker(
                  context,
                  iconPackModes: [
                    IconPack.cupertino,
                    IconPack.fontAwesomeIcons,
                    IconPack.lineAwesomeIcons,
                    IconPack.material,
                  ],
                );
                setState(() {});
              },
              child: Text(
                StringsManager.chooseIcon.tr(),
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: Colors.white),
              ),
            )
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }
}
