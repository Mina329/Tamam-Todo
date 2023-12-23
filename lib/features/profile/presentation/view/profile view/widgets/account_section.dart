import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/core/widgets/custom_icons/custom_icons_icons.dart';
import 'package:todo/core/widgets/save_cancel_action_buttons.dart';
import 'package:todo/features/profile/presentation/view/profile%20view/widgets/custom_list_tile.dart';
import 'package:todo/features/profile/presentation/view/profile%20view/widgets/custom_profile_section_title.dart';
import 'dart:io';

class AccountSection extends StatefulWidget {
  const AccountSection({super.key});

  @override
  State<AccountSection> createState() => _AccountSectionState();
}

class _AccountSectionState extends State<AccountSection> {
  final List<IconData> icons = [
    CustomIcons.inactive_profile_icon,
    CustomIcons.password_icon,
    CustomIcons.camera_icon,
  ];

  final List<String> names = [
    StringsManager.changeAccountName,
    StringsManager.changeAccountPassword,
    StringsManager.changeAccountImage
  ];

  late List<void Function(BuildContext context)> functions;
  File? _imageFile;
  @override
  void initState() {
    super.initState();

    functions = [
      _buildChangeAccountName,
      _buildChangeAccountPassword,
      _buildImagePicker,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomProfileSectionTitle(
          title: StringsManager.account,
        ),
        SizedBox(
          height: 5.h,
        ),
        Column(
          children: List.generate(
            3,
            (index) => Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: CustomListTile(
                icon: icons[index],
                name: names[index],
                onTap: () {
                  functions[index](context);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _buildImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 30.w,
          vertical: 30.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                GoRouter.of(context).pop();
                _getImage(ImageSource.gallery);
              },
              child: Icon(
                Icons.image,
                size: 50.sp,
              ),
            ),
            GestureDetector(
              onTap: () {
                GoRouter.of(context).pop();
                _getImage(ImageSource.camera);
              },
              child: Icon(
                Icons.camera_alt,
                size: 50.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _buildChangeAccountPassword(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                StringsManager.changeAccountPassword,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(
                height: 5.h,
              ),
              const Divider(),
              SizedBox(
                height: 5.h,
              ),
              SizedBox(
                height: 43.h,
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.bottom,
                  style: Theme.of(context).textTheme.headlineSmall,
                  decoration: const InputDecoration(
                    label: Text(
                      StringsManager.oldPassword,
                    ),
                    hintText: StringsManager.oldPassword,
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              SizedBox(
                height: 43.h,
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.bottom,
                  style: Theme.of(context).textTheme.headlineSmall,
                  decoration: const InputDecoration(
                    label: Text(
                      StringsManager.newPassword,
                    ),
                    hintText: StringsManager.newPassword,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              SaveCancelActionButtons(
                cancelOnPressed: () {
                  GoRouter.of(context).pop();
                },
                saveOnPressed: () {
                  GoRouter.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _buildChangeAccountName(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                StringsManager.changeAccountName,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(
                height: 5.h,
              ),
              const Divider(),
              SizedBox(
                height: 5.h,
              ),
              SizedBox(
                height: 43.h,
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.bottom,
                  style: Theme.of(context).textTheme.headlineSmall,
                  decoration: const InputDecoration(
                    label: Text(
                      StringsManager.accountName,
                    ),
                    hintText: StringsManager.accountName,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              SaveCancelActionButtons(
                cancelOnPressed: () {
                  GoRouter.of(context).pop();
                },
                saveOnPressed: () {
                  GoRouter.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
