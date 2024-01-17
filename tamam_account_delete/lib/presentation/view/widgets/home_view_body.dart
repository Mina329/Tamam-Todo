import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tamam_account_delete/core/loading_animation.dart';
import 'package:tamam_account_delete/presentation/managers/delete_account_with_email_and_password_cubit/delete_account_with_email_and_password_cubit.dart';
import 'package:tamam_account_delete/presentation/managers/delete_account_with_google_cubit/delete_account_with_google_cubit.dart';
import 'package:tamam_account_delete/presentation/view/widgets/login_form.dart';
import 'package:tamam_account_delete/presentation/view/widgets/logo_and_name.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const LogoAndName(),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        ),
        LoginForm(
          formKey: formKey,
          onSavedEmail: (p0) {
            email = p0;
          },
          onSavedPassword: (p0) {
            password = p0;
          },
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        ),
        Flexible(
          flex: 5,
          child: Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.05,
              child: FittedBox(
                child: BlocListener<DeleteAccountWithEmailAndPasswordCubit,
                    DeleteAccountWithEmailAndPasswordState>(
                  listener: (context, state) {
                    if (state is DeleteAccountWithEmailAndPasswordLoading) {
                      CustomLoadingAnimation.buildLoadingIndicator(context);
                    } else if (state
                        is DeleteAccountWithEmailAndPasswordFailure) {
                      Navigator.pop(context);
                      Fluttertoast.showToast(msg: state.errMessage);
                    } else if (state
                        is DeleteAccountWithEmailAndPasswordSuccess) {
                      Navigator.pop(context);
                      Fluttertoast.showToast(
                          msg: 'Account deleted successfully');
                    }
                  },
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        BlocProvider.of<DeleteAccountWithEmailAndPasswordCubit>(
                                context)
                            .deleteAccountWithEmailAndPassword(
                                email!, password!);
                      }
                    },
                    child: const Text('Delete Account'),
                  ),
                ),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 5,
          child: Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.05,
              child: BlocListener<DeleteAccountWithGoogleCubit,
                  DeleteAccountWithGoogleState>(
                listener: (context, state) {
                  if (state is DeleteAccountWithGoogleLoading) {
                    CustomLoadingAnimation.buildLoadingIndicator(context);
                  } else if (state is DeleteAccountWithGoogleFailure) {
                    Navigator.pop(context);
                    Fluttertoast.showToast(msg: state.errMessage);
                  } else if (state is DeleteAccountWithGoogleSuccess) {
                    Navigator.pop(context);
                    Fluttertoast.showToast(msg: 'Account deleted successfully');
                  }
                },
                child: ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<DeleteAccountWithGoogleCubit>(context)
                        .deleteAccountWithGoogle();
                  },
                  child: FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/google_icon.svg',
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Delete Account Signed with Google',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
