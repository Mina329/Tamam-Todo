import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/utils/strings_manager.dart';

class CategoryNameSection extends StatelessWidget {
  const CategoryNameSection({
    super.key,
    required this.categoryNameKey,
    this.onSaved,
  });
  final GlobalKey<FormFieldState<String>> categoryNameKey;
  final Function(String?)? onSaved;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          StringsManager.categoryName.tr(),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        SizedBox(
          height: 15.h,
        ),
        TextFormField(
          key: categoryNameKey,
          style: Theme.of(context).textTheme.headlineSmall,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(15),
            label: Text(
              StringsManager.categoryName.tr(),
              style: Theme.of(context).textTheme.labelMedium,
              overflow: TextOverflow.ellipsis,
            ),
            hintText: StringsManager.categoryName.tr(),
          ),
          validator: (value) {
            if (value == null || value.length < 3 || value.length > 10) {
              return StringsManager.categoryNameValidation.tr();
            }
            return null;
          },
          onSaved: onSaved,
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }
}
