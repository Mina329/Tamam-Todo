import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo/core/utils/strings_manager.dart';

class FaqListView extends StatefulWidget {
  const FaqListView({
    super.key,
  });

  @override
  State<FaqListView> createState() => _FaqListViewState();
}

class _FaqListViewState extends State<FaqListView> {
  final List<String> questions = [
    StringsManager.q1.tr(),
    StringsManager.q2.tr(),
    StringsManager.q3.tr(),
    StringsManager.q4.tr(),
    StringsManager.q5.tr(),
    StringsManager.q6.tr(),
    StringsManager.q7.tr(),
    StringsManager.q8.tr(),
    StringsManager.q9.tr(),
    StringsManager.q10.tr(),
    StringsManager.q11.tr(),
  ];

  final List<String> answers = [
    StringsManager.q1A.tr(),
    StringsManager.q2A.tr(),
    StringsManager.q3A.tr(),
    StringsManager.q4A.tr(),
    StringsManager.q5A.tr(),
    StringsManager.q6A.tr(),
    StringsManager.q7A.tr(),
    StringsManager.q8A.tr(),
    StringsManager.q9A.tr(),
    StringsManager.q10A.tr(),
    StringsManager.q11A.tr(),
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: ListView(
          children: List.generate(
            12,
            (index) {
              if (index == 11) {
                return ListTile(
                  title: Text(
                    StringsManager.faqDescription.tr(),
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                );
              }
              return ListTile(
                title: Text(
                  questions[index],
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                subtitle: Text(
                  answers[index],
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
