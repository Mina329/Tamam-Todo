import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/cache/cache_helper.dart';
import 'package:todo/core/cache/cache_keys_values.dart';
import 'package:todo/core/utils/app_router.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/core/widgets/custom_icons/custom_icons_icons.dart';
import 'package:todo/features/profile/presentation/view/profile%20view/widgets/custom_list_tile.dart';
import 'package:todo/main.dart';

class SettingsListTiles extends StatefulWidget {
  const SettingsListTiles({
    super.key,
  });

  @override
  State<SettingsListTiles> createState() => _SettingsListTilesState();
}

class _SettingsListTilesState extends State<SettingsListTiles> {
  final Map<String, Locale> locales = {
    StringsManager.english.tr(): const Locale('en'),
    StringsManager.french.tr(): const Locale('fr'),
    StringsManager.arabic.tr(): const Locale('ar'),
    StringsManager.german.tr(): const Locale('de'),
    StringsManager.spanish.tr(): const Locale('es'),
    StringsManager.hindi.tr(): const Locale('hi'),
    StringsManager.chinese.tr(): const Locale('zh'),
  };
  final Map<String, ThemeMode> themes = {
    StringsManager.lightMode.tr(): ThemeMode.light,
    StringsManager.darkMode.tr(): ThemeMode.dark,
  };
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomListTile(
          icon: CustomIcons.change_theme_icon,
          name: StringsManager.changeAppColor.tr(),
          onTap: () {
            _showDynamicDialog(
              context: context,
              dialogTitle: StringsManager.changeAppColor.tr(),
              options: themes.keys.toList(),
              groupValue: Theme.of(context).brightness == Brightness.dark
                  ? StringsManager.darkMode.tr()
                  : StringsManager.lightMode.tr(),
              onChanged: (value) {
                notifier.value = themes[value]!;
                value == StringsManager.lightMode.tr()
                    ? CacheData.setData(
                        key: CacheKeys.kDARKMODE, value: CacheValues.LIGHT)
                    : CacheData.setData(
                        key: CacheKeys.kDARKMODE, value: CacheValues.DARK);
              },
            );
          },
        ),
        SizedBox(
          height: 16.h,
        ),
        CustomListTile(
          icon: CustomIcons.language_icon,
          name: StringsManager.changeAppLanguage.tr(),
          onTap: () {
            _showDynamicDialog(
              context: context,
              dialogTitle: StringsManager.changeAppLanguage.tr(),
              options: locales.keys.toList(),
              groupValue: getKeyForLocale(context.locale, locales)!,
              onChanged: (value) {
                context.setLocale(locales[value]!);
                GoRouter.of(context).go(AppRouter.kSplashView);
              },
            );
          },
        ),
      ],
    );
  }

  String? getKeyForLocale(dynamic value, Map<String, dynamic> locales) {
    for (var entry in locales.entries) {
      if (entry.value == value) {
        return entry.key;
      }
    }
    return null;
  }

  void _showDynamicDialog(
      {required BuildContext context,
      required String dialogTitle,
      required List<String> options,
      required String groupValue,
      required Function(String) onChanged}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                dialogTitle,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: options.map((option) {
                  return RadioListTile(
                    title: Text(
                      option,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    value: option,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        onChanged(value!);
                        Navigator.of(context).pop();
                      });
                    },
                  );
                }).toList(),
              ),
            );
          },
        );
      },
    );
  }
}
