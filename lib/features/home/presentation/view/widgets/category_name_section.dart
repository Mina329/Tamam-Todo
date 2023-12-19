import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/utils/strings_manager.dart';

class CategoryNameSection extends StatelessWidget {
  const CategoryNameSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          StringsManager.categoryName,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        SizedBox(
          height: 15.h,
        ),
        Form(
          child: SizedBox(
            height: 50.h,
            child: TextFormField(
              style: Theme.of(context).textTheme.headlineSmall,
              textAlignVertical: TextAlignVertical.bottom,
              decoration: const InputDecoration(
                label: Text(
                  StringsManager.categoryName,
                ),
                hintText: StringsManager.categoryName,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }
}
