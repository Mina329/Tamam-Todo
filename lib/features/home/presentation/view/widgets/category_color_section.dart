import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/utils/color_manager.dart';
import 'package:todo/core/utils/strings_manager.dart';

class CategoryColorSection extends StatefulWidget {
  const CategoryColorSection({
    super.key,
  });

  @override
  State<CategoryColorSection> createState() => _CategoryColorSectionState();
}

class _CategoryColorSectionState extends State<CategoryColorSection> {
  Color? color;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          StringsManager.categoryColor.tr(),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        SizedBox(
          height: 15.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            color == null
                ? const SizedBox()
                : Container(
                    width: 35.w,
                    height: 35.w,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
            ElevatedButton(
              onPressed: () {
                _buildColorPicker(context);
              },
              child: Text(
                StringsManager.chooseColor.tr(),
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: Colors.white),
              ),
            )
          ],
        )
      ],
    );
  }

  void _buildColorPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          StringsManager.pickAColor.tr(),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: ColorManager.primaryColor,
            onColorChanged: (Color selectedColor) {
              color = selectedColor;
            },
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: Text(
              StringsManager.save.tr(),
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Colors.white),
            ),
            onPressed: () {
              color ??= ColorManager.primaryColor;
              setState(() {});
              GoRouter.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
