import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo/core/utils/service_locator.dart';
import 'package:todo/core/utils/strings_manager.dart';
import 'package:todo/core/widgets/custom_icons/custom_icons_icons.dart';
import 'package:todo/core/widgets/custom_loading_animation.dart';
import 'package:todo/core/widgets/save_cancel_action_buttons.dart';
import 'package:todo/features/profile/domain/usecases/change_account_name_use_case.dart';
import 'package:todo/features/profile/domain/usecases/change_account_password_use_case.dart';
import 'package:todo/features/profile/domain/usecases/change_account_photo_use_case.dart';
import 'package:todo/features/profile/presentation/managers/change_account_name_cubit/change_account_name_cubit.dart';
import 'package:todo/features/profile/presentation/managers/change_account_password_cubit/change_account_password_cubit.dart';
import 'package:todo/features/profile/presentation/managers/change_account_photo_cubit/change_account_photo_cubit.dart';
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
    StringsManager.changeAccountName.tr(),
    StringsManager.changeAccountPassword.tr(),
    StringsManager.changeAccountImage.tr()
  ];

  late List<void Function(BuildContext context)> functions;
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
        CustomProfileSectionTitle(
          title: StringsManager.account.tr(),
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
      builder: (context) => BlocProvider(
        create: (context) => ChangeAccountPhotoCubit(
          getIt.get<ChangeAccountPhotoUseCase>(),
        ),
        child: StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30.w,
                vertical: 30.h,
              ),
              child: BlocListener<ChangeAccountPhotoCubit,
                  ChangeAccountPhotoState>(
                listener: (context, state) {
                  if (state is ChangeAccountPhotoLoading) {
                    CustomLoadingAnimation.buildLoadingIndicator(context);
                  } else if (state is ChangeAccountPhotoFailure) {
                    GoRouter.of(context).pop();
                    GoRouter.of(context).pop();
                    Fluttertoast.showToast(msg: state.errMessage);
                  } else if (state is ChangeAccountPhotoSuccess) {
                    GoRouter.of(context).pop();
                    GoRouter.of(context).pop();
                    Fluttertoast.showToast(
                        msg: StringsManager.profilePhotoUpdatedSuccessfully
                            .tr());
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        File? image = await _getImage(ImageSource.gallery);
                        if (image != null && context.mounted) {
                          BlocProvider.of<ChangeAccountPhotoCubit>(context)
                              .changeAccountPhoto(image);
                        }
                      },
                      child: Icon(
                        Icons.image,
                        size: 50.sp,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        File? image = await _getImage(ImageSource.camera);
                        if (image != null && context.mounted) {
                          BlocProvider.of<ChangeAccountPhotoCubit>(context)
                              .changeAccountPhoto(image);
                        }
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
          },
        ),
      ),
    );
  }

  Future<File?> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  void _buildChangeAccountPassword(BuildContext context) {
    final GlobalKey<FormFieldState<String>> oldPasswordKey =
        GlobalKey<FormFieldState<String>>();
    final GlobalKey<FormFieldState<String>> newPasswordKey =
        GlobalKey<FormFieldState<String>>();
    late String oldPassword;
    late String newPassword;
    bool oldPasswordObsecured = true;
    bool newPasswordObsecured = true;
    showDialog(
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => ChangeAccountPasswordCubit(
          getIt.get<ChangeAccountPasswordUseCase>(),
        ),
        child: Dialog(
          child: StatefulBuilder(
            builder: (context, setState) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      StringsManager.changeAccountPassword.tr(),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    const Divider(),
                    SizedBox(
                      height: 5.h,
                    ),
                    TextFormField(
                      key: oldPasswordKey,
                      style: Theme.of(context).textTheme.headlineSmall,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              oldPasswordObsecured = !oldPasswordObsecured;
                            });
                          },
                          icon: Icon(
                            oldPasswordObsecured
                                ? Icons.visibility_off
                                : Icons.remove_red_eye,
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(15),
                        label: Text(
                          StringsManager.oldPassword.tr(),
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        hintText: StringsManager.oldPassword.tr(),
                      ),
                      obscureText: oldPasswordObsecured,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return StringsManager.passwordValidation.tr();
                        }
                        return null;
                      },
                      onChanged: (value) {
                        oldPassword = value;
                      },
                      onSaved: (value) {
                        oldPassword = value!;
                      },
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    TextFormField(
                      key: newPasswordKey,
                      style: Theme.of(context).textTheme.headlineSmall,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              newPasswordObsecured = !newPasswordObsecured;
                            });
                          },
                          icon: Icon(
                            newPasswordObsecured
                                ? Icons.visibility_off
                                : Icons.remove_red_eye,
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(15),
                        label: Text(
                          StringsManager.newPassword.tr(),
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        hintText: StringsManager.newPassword.tr(),
                      ),
                      obscureText: newPasswordObsecured,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return StringsManager.passwordValidation.tr();
                        }
                        if (value == oldPassword) {
                          return StringsManager.oldNewPassword.tr();
                        }
                        String validationMessage = _validatePassword(value);
                        if (validationMessage.isNotEmpty) {
                          return validationMessage;
                        }
                        return null;
                      },
                      onSaved: (value) {
                        newPassword = value!;
                      },
                    ),
                    SizedBox(height: 16.h),
                    BlocListener<ChangeAccountPasswordCubit,
                        ChangeAccountPasswordState>(
                      listener: (context, state) {
                        if (state is ChangeAccountPasswordLoading) {
                          CustomLoadingAnimation.buildLoadingIndicator(context);
                        } else if (state is ChangeAccountPasswordFailure) {
                          GoRouter.of(context).pop();
                          Fluttertoast.showToast(msg: state.errMessage);
                        } else if (state is ChangeAccountPasswordSuccess) {
                          GoRouter.of(context).pop();
                          GoRouter.of(context).pop();
                          Fluttertoast.showToast(
                            msg:
                                StringsManager.passwordUpdatedSuccessfully.tr(),
                          );
                        }
                      },
                      child: SaveCancelActionButtons(
                        cancelOnPressed: () {
                          GoRouter.of(context).pop();
                        },
                        saveOnPressed: () {
                          if (oldPasswordKey.currentState!.validate()) {
                            oldPasswordKey.currentState!.save();
                            if (newPasswordKey.currentState!.validate()) {
                              newPasswordKey.currentState!.save();
                              BlocProvider.of<ChangeAccountPasswordCubit>(
                                      context)
                                  .changeAccountPassword(
                                      oldPassword, newPassword);
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  String _validatePassword(String password) {
    RegExp lowercaseRegex = RegExp(r'[a-z]');
    RegExp uppercaseRegex = RegExp(r'[A-Z]');
    RegExp digitRegex = RegExp(r'\d');
    RegExp specialCharRegex = RegExp(r'[!@#$%^&*()_+{}\[\]:;<>,.?~\\/-]');
    int minLength = 6;
    int maxLength = 4096;

    if (!lowercaseRegex.hasMatch(password)) {
      return StringsManager.lowercaseValidation.tr();
    }

    if (!uppercaseRegex.hasMatch(password)) {
      return StringsManager.uppercaseValidation.tr();
    }

    if (!digitRegex.hasMatch(password)) {
      return StringsManager.numberValidation.tr();
    }

    if (!specialCharRegex.hasMatch(password)) {
      return StringsManager.specialValidation.tr();
    }

    if (password.length < minLength || password.length > maxLength) {
      return StringsManager.lengthValidation.tr();
    }

    return '';
  }

  void _buildChangeAccountName(BuildContext context) async {
    final GlobalKey<FormFieldState<String>> changeNameKey =
        GlobalKey<FormFieldState<String>>();

    await showDialog(
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => ChangeAccountNameCubit(
          getIt.get<ChangeAccountNameUseCase>(),
        ),
        child: Dialog(
          child: StatefulBuilder(
            builder: (context, setState) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      StringsManager.changeAccountName.tr(),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    const Divider(),
                    SizedBox(
                      height: 5.h,
                    ),
                    TextFormField(
                      key: changeNameKey,
                      style: Theme.of(context).textTheme.headlineSmall,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(15),
                        label: Text(
                          StringsManager.accountName.tr(),
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        hintText: StringsManager.accountName.tr(),
                      ),
                      validator: (value) {
                        if (value == null || value.length < 3) {
                          return StringsManager.nameValidation.tr();
                        }
                        return null;
                      },
                      onSaved: (value) {
                        BlocProvider.of<ChangeAccountNameCubit>(context)
                            .changeAccountName(value!);
                      },
                    ),
                    SizedBox(height: 16.h),
                    BlocListener<ChangeAccountNameCubit,
                        ChangeAccountNameState>(
                      listener: (context, state) {
                        if (state is ChangeAccountNameLoading) {
                          CustomLoadingAnimation.buildLoadingIndicator(context);
                        } else if (state is ChangeAccountNameFailure) {
                          GoRouter.of(context).pop();
                          Fluttertoast.showToast(msg: state.errMessage);
                        } else if (state is ChangeAccountNameSuccess) {
                          GoRouter.of(context).pop();
                          GoRouter.of(context).pop();
                          Fluttertoast.showToast(
                              msg: StringsManager.nameUpdatedSuccessfully.tr());
                        }
                      },
                      child: SaveCancelActionButtons(
                        cancelOnPressed: () {
                          GoRouter.of(context).pop();
                        },
                        saveOnPressed: () {
                          if (changeNameKey.currentState!.validate()) {
                            changeNameKey.currentState!.save();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
