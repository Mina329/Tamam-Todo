import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/features/profile/presentation/view/faq%20view/widgets/faq_list_view.dart';

class FaqViewBody extends StatelessWidget {
  const FaqViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                StringsManager.faq.tr(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Spacer(),
            ],
          ),
        ),
        const FaqListView(),
      ],
    );
  }
}
